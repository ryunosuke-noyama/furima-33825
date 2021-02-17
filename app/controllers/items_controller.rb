class ItemsController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
  end

  private

  def item_params
    params.require(:item).permit(:image).merge(user_id: current_user.id)
  end
  
end
