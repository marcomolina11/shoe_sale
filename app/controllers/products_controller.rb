class ProductsController < ApplicationController
  def index
  	@user = User.find(session[:user_id])
  	products = Product.all
  	purchases = Purchase.all
  	@for_sale_products = []

  	products.each {|product|
  		for_sale = true
  		purchases.each {|purchase|
  			if purchase.product == product
  				for_sale = false
  			end
  		}
  		if for_sale == true
  			@for_sale_products << product
  		end
  	}

  end

  def create
  	user = User.find(session[:user_id])
    product = user.products.new(name:params[:name], amount:params[:amount])
    if product.valid?
      product.save
      redirect_to "/dashboard/#{user.id}"
    else
      redirect_to "/dashboard/#{user.id}", alert: product.errors.full_messages
    end
  end

  def destroy
  	user = User.find(session[:user_id])
  	Product.find(params[:id]).destroy
  	redirect_to "/dashboard/#{user.id}"
  end
end
