class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def set_item_by_code
    @item = Item.find_by!(code: params[:code])

    render status: 404, text: '' if @item.nil?
  end
end
