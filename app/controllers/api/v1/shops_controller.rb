class Api::V1::ShopsController < Api::V1::ApplicationController
	def index
		authorize Shop
		stores = Shop.all.paginate(page: params[:page], per_page: params[:per_page])
		render :json=>{
				code: 200,
				message: "Sucessfully fetched",
				shops: stores.as_json({ 
							include: { region: {except: [:created_at, :updated_at, :region]}},
							except: [:created_at, :updated_at, :region_id]
						})
			}
	end
end
