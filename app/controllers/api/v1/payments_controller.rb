class Api::V1::PaymentsController < Api::V1::ApplicationController
	before_action :find_order

	def create
		# Final checkout for order and initiate payment
		# From here a task will triggered after 1 minute that updates the state of the order to either paid or unpaid
		if @order.order_total.to_f>0
			payment_checkout = current_user.fake_payments.create(order_id: @order.id, amount: @order.order_total)
			
			begin
				PaymentWorker.perform_in(1.minutes, payment_checkout.id)
			rescue => e
				# Redis and Sidekiq should be run to execute this worker task
			end
			render :json => {
				code: 200,
				message: "Sucessfully initiated",
				orders: payment_checkout.as_json
			}
		else
			unless @order
				render :json => {
					code: 422,
					message: "Order amount should be greater than Zero to initiate payment"
				}, status: 422
			end
		end
	end

	def update
		# Here we will update fake status if payment success or failed
		@payment_checkout = @order.fake_payments.find_by_id(params[:id])
		unless @payment_checkout
			render :json => {
				code: 404,
				message: "Payment does not exists"
			}, status: 404
		else
			authorize @payment_checkout
			@payment_checkout.update(payment_status: params[:status].to_s.downcase=="success" ? "success" : "failed")
			render :json => {
				code: 200,
				message: "Sucessfully updated",
				orders: @payment_checkout.as_json
			}
		end
	end

	private
	def find_order
		@order = current_user.orders.find_by_id(params[:order_id])
		unless @order
			render :json => {
				code: 404,
				message: "Order does not exists"
			}, status: 404
		end
	end
end
