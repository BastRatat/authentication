class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :update, :destroy]
  before_action :authorized, except: [:total, :update]

  # DELETE /volunteers
  def remove_all
    all_requests = Request.all
    all_requests.destroy_all
    render json: {success: "All requests have been removed from the Request table."}
  end

  def total
    @total = Request.all.where(status: "unfulfilled")
    render json: @total.length()
  end

  # GET /requests
  def index
    @requests = Request.all

    render json: @requests
  end

  # GET /requests/1
  def show
    render json: @request
  end

  # POST /requests
  def create
    @request = Request.new(request_params)

    if @request.save
      render json: @request, status: :created
    else
      render json: @request.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /requests/1
  def update
    if @request.update(request_params)
      render json: @request
    else
      render json: @request.errors, status: :unprocessable_entity
    end
  end

  # DELETE /requests/1
  def destroy
    @request.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def request_params
      params.permit(:user_id, :title, :request_type, :description, :location, :status)
    end
end
