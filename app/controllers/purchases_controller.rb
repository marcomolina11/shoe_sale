class PurchasesController < ApplicationController
  def create
  	product = Product.find(params[:product_id])
  	buyer = User.find(session[:user_id])
  	#create purchase for buyer
  	Purchase.create(user:buyer, product:product)
  	redirect_to "/dashboard/#{buyer.id}", notice: "Purchase Succesful"
  end

  def destroy
  end
end
