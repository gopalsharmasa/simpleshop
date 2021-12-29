class Api::V1::OrderItemsController < Api::V1::ApplicationController
	before_action :find_order
	before_action :find_product, only: [:create, :update]
	before_action :find_order_item, only: [:update, :show, :destroy]

	def index
		@order_items = @order.order_items.order(created_at: "DESC").paginate(page: params[:page], per_page: params[:per_page])
		authorize OrderItem
		render :json => {
				code: 200,
				message: "Sucessfully fetched",
				order_items: @order_items.as_json(except: [:created_at, :updated_at])
			}
	end

	def create
		@order_item = @order.order_items.new(require_params)
		authorize @order_item
		if @order_item.save
			render :json=> {
				code: 200,
				message: "Successfully created",
				order_item: @order_item.as_json(except: [:created_at, :updated_at])
			}
		else
			render :json=> {
				code: 401,
				message: @order_item.errors.full_messages.join(", ")
			}, status: 401
		end
	end

	def update
		authorize @order_item
		if @order_item.update(require_params)
			render :json=> {
				code: 200,
				message: "Successfully updated",
				order_item: @order_item.as_json(except: [:created_at, :updated_at])
			}
		else
			render :json=> {
				code: 401,
				message: @order_item.errors.full_messages.join(", ")
			}, status: 401
		end
	end

	def destroy
		authorize @order_item
		@order_item.destroy
		render :json=> {
				code: 200,
				message: "Successfully deleted",
			}
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

	def find_order_item
		@order_item = @order.order_items.find_by_id(params[:id])
		unless @order_item
			render :json => {
				code: 404,
				message: "Order item does not exists"
			}, status: 404
		end
	end

	def find_product
		@product = Product.find_by_id(params[:order_item][:product_id])
		unless @product
			render :json => {
				code: 404,
				message: "Product does not exists"
			}, status: 404
		end
	end

	def require_params
		params.require(:order_item).permit(:product_id, :quantity)
	end

end
