class ItemSessionsController < ApplicationController
  before_action :set_item_by_code, except: [:client, :search]
  before_action :set_session, only: [:show, :update]

  skip_before_action :verify_authenticity_token

  def index
    @sessions = ItemSession.all
    @sessions = @sessions.where(checked_in_at: nil) if params[:current] == '1'
  end

  def show; end

  def client

  end

  def search
    results = params[:q].empty? ? SKU.first(10) : SKU.search(params[:q])
    render json: {skus: results.map{ |sku| {name: sku.name, id: sku.id} }}
  end

  def create
    @session = @item.item_sessions.create(session_params)

    if @session.errors.empty?
      render 'show'
    else
      render json: @session.errors, status: :bad_request
    end
  end

  def update
    @session.update_attributes(session_params)

    if @session.errors.empty?
      render 'show'
    else
      render json: @session.errors, status: :bad_request
    end
  end

  private
  def session_params
    params.permit(:checked_out_at, :checked_in_at, :usage, :unit)
  end

  def set_session
    return @session = @item.current_sessions.first! if params[:id] == 'current'
    @session = ItemSession.find(params[:id])
  end
end
