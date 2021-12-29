class Api::V1::OrdersController < Api::V1::ApplicationController
	before_action :find_order, only: [:update, :show, :destroy]

	def index
		@orders = current_user.orders.order(created_at: "DESC").paginate(page: params[:page], per_page: params[:per_page])
		authorize Order
		render :json => {
				code: 200,
				message: "Sucessfully fetched",
				orders: order_json(@orders)
			}
	end

	def create
		@order = current_user.orders.new(order_params)
		authorize @order, :update?
		if @order.save
			render :json=> {
				code: 200,
				message: "Successfully created",
				order: order_json(@order)
			}
		else 
			render :json=> {
				code: 401,
				message: @order.errors.full_messages.join(", ")
			}, status: 401
		end
	end

	def update
		authorize @order
		if @order.update(order_params)
			render :json=> {
				code: 200,
				message: "Successfully updated",
				order: order_json(@order)
			}
		else
			render :json=> {
				code: 401,
				message: @order.errors.full_messages.join(", ")
			}, status: 401
		end
	end

	def show
		authorize @order
		render :json=> {
				code: 200,
				message: "Successfully fetched",
				order: order_json(@order)
			}
	end

	def destroy
		authorize @order
		@order.destroy
		render :json=> {
				code: 200,
				message: "Successfully deleted",
			}
	end

	private
	def find_order
		@order = current_user.orders.find_by_id(params[:id])
		unless @order
			render :json => {
				code: 404,
				message: "Order does not exists"
			}, status: 404
		end
	end

	def order_params
		params.require(:order).permit(:customer_name, :shipping_address)
	end

	def order_json data
		data.as_json({
			except: [:updated_at, :shop_id, :user_id],
			include: {
				order_items: {
					only: [:id, :quantity],
					include: {
						product: { except: [:created_at, :updated_at] }
					}
				}
			}
		})
	end
end
