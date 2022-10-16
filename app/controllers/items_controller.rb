class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if user
        items = user.items
        return render json: items, include: :user
      else
        return render json: { error: "User Not Found" }, status: :not_found
      end
    else
      items = Item.all
      return render json: items, include: :user
    end
  end

  def show
    item = Item.find_by(id: params[:id])
    if item
      render json: item, include: :user
    else
      render json: { error: "Item Not Found" }, status: :not_found
    end
  end

  def create
    user = User.find_by(id: params[:user_id])
    if user
      new_item = user.items.create(name: params[:name], description: params[:description], price: params[:price])
      render json: new_item, status: :created
    else
      render json: { error: "User Not Found" }, status: :not_found
    end
  end

end
