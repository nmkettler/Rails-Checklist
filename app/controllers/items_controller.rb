class ItemsController < ApplicationController
	before_action :find_item, only: [:show, :edit, :updtae, :destroy]
	
	def index
		if user_signed_in?
		@items = Item.where(:user_id => current_user.id).order("created_at DESC")
		end
	end
	
	def show
		
	end
	
	def new
		@item = current_user.items.build
	end
	
	def create
		@item = current_user.items.build(item_params)
		if @item.save
			redirect_to root_path
		else
			render 'new'
		end
	end
	
	def edit
	end
	
	def update
	@item = Item.find(params[:id])
		if @item.update(item_params)
			redirect_to root_path item_path(@item)
		else
			render 'edit'
		end
	end
	
	def destroy
		@item.destroy
		redirect_to action: "index"
	end
	
	def complete
		@item = Item.find(params[:id])
		@item.update_attribute(:completed_at, Time.now)
		redirect_to root_path, notice: "Item successfully completed!"
	end
	
	private
	
	def item_params
		(params.require(:item).permit(:title, :description))
	end
	def find_item
		@item = Item.find(params[:id])
	end
	
end
