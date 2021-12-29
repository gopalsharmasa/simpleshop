class Api::V1::ProductsController < Api::V1::ApplicationController
	before_action :find_shop
	before_action :find_product, only: [:update, :show]

	def index
		@products = Product.all.paginate(page: params[:page], per_page: params[:per_page])
		authorize Product
		render :json=>{
				code: 200,
				message: "Sucessfully fetched",
				products: @products.as_json(except:[:created_at,:updated_at,:shop_id])
			}
	end

	def show
		authorize @product, :index?
		render :json=>{
				code: 200,
				message: "Successfully fetched",
				product: product_json
			}
	end

	def create
		@product = @shop.products.new(product_params)
		authorize @product, :update?
		if @product.save
			render :json=> {
				code: 200,
				message: "Successfully created",
				product: product_json
			}
		else 
			render :json=> {
				code: 401,
				message: @product.errors.full_messages.join(", ")
			}, status: 401
		end
	end

	def update
		authorize @product
  		if @product.update(product_params)
  			render :json=> {
  				code: 200,
  				message: "Updated successfully",
  				user: product_json
  			}
  		else 
  			render :json=>{
  				code: 401, 
  				message: @product.errors.full_messages.join(", ")
  			}, status: 401
  		end
	end

	private 
	def find_product
		@product = Product.find_by_id(params[:id])
		unless @product
			render :json=>{
				code: 404,
				message: "Product does not exists"
			}, status: 404
		end
	end

	def find_shop
		@shop = Shop.find_by_id(params[:shop_id])
		unless @shop
			render :json=>{
				code: 404,
				message: "Shop does not exists"
			}, status: 404
		end
	end

	def product_json
		@product.as_json({
			except:[:created_at,:updated_at,:shop_id],
			include: {
				shop: {only: [:title]}
			}
		})
	end

	def product_params
		params.require(:product).permit(:title, :description, :price, :sku, :stock)
	end

end
