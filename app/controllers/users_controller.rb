class UsersController < ApplicationController
  def index
  end

  def login
    user = User.find_by_email(params[:email])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/shoes'
    else
      redirect_to '/main', :alert => ["Invalid email/password"]
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to '/main'
  end

  def new
  end

  def create
    user = User.new(first_name:params[:first_name], last_name:params[:last_name], email:params[:email], password:params[:password], password_confirmation:params[:password_confirmation])
    if user.valid?
      user.save
      session[:user_id] = user.id
      redirect_to '/shoes'
    else
      redirect_to '/main', alert: user.errors.full_messages
    end
  end

  def dashboard
    @user = User.find(params[:id])
    @my_products = @user.products
    @my_purchases = Purchase.where(user:@user)
    @all_purchases = Purchase.all
    @sold_products = []
    @pending_products = []
    @my_sales = []
    @total_sales = 0.00
    @total_purchases = 0.00

    @all_purchases.each {|purchase|
      if @my_products.include?(purchase.product)
        @my_sales << purchase
        @sold_products << purchase.product
      end
    }

    @my_products.each {|product|
      sold = false
      if @sold_products.include?(product)
        sold = true
      end
      if sold == false
        @pending_products << product
      end
    }

  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
