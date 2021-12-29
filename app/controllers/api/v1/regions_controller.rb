class Api::V1::RegionsController < Api::V1::ApplicationController

	def index
		authorize Region
		regions = Region.all.paginate(page: params[:page], per_page: params[:per_page])
		render :json=>{
				code: 200,
				message: "Sucessfully fetched",
				region: regions.as_json(except:[:created_at, :updated_at])
			}
	end

 	def create
		@region = Region.new(check_params)
		authorize @region, :update?
		if @region.save
			render :json=>{
				code: 200,
				message: "Successfully created",
				region: @region.as_json(except:[:created_at,:updated_at])
			}
		else 
			render :json=>{
				code: 401,
				message: @region.errors.full_messages.join(", ")
			}, status: 401
		end
	end

	def update
		@region = Region.find_by_id(params[:id])
		authorize @region
		unless @region.update(check_params)
			render :json=>{
				code: 401,
				message: @region.errors.full_messages.join(", ")
			}, status: 401
		else
			render :json=>{
				code: 200,
				message: "Sucessfully updated",
				region: @region.as_json
			}
		end
	end

	private
	def check_params
		params.require(:region).permit(:title, :country, :currency, :tax)
	end
end
