class PaymentWorker
	include Sidekiq::Worker
	sidekiq_options :retry => false
	
	def perform fake_payment_id
		payment = FakePayment.find_by_id(fake_payment_id)
		if payment
			if ["success", "failed"].include?(payment.payment_status)
				order = payment.order
				order.update(paid: payment.payment_status=="success", paid_at: payment.updated_at)
			elsif payment.payment_status=="initiated"
				# Reschedule check again after 1 minute
				PaymentWorker.perform_in(1.minutes, payment.id)
			end
		end
	end
end