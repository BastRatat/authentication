class VolunteersController < ApplicationController
  before_action :set_volunteer, only: [:show, :update, :destroy]
  before_action :set_id, only: [:index, :create]

  # GET /volunteers
  def index
    # INDEX ACTION HAS TO RETRIEVE ALL THE VOLUNTEERS FOR A SPECIFIC REQUEST
    @volunteers = Volunteer.all.where(request_id: @request_id)
    render json: @volunteers
  end

  # GET /volunteers/1
  def show
    render json: @volunteer
  end

  # POST /volunteers
  def create
    @volunteer = Volunteer.new(volunteer_params)
    volunteers = Volunteer.all.where(request_id: @request_id)
    if volunteers.length() >= 5
      render json: {
        status: :forbidden,
        'error': 'This request cannot have more volunteers'
      }
    else
      if @volunteer.save
        render json: @volunteer, status: :created
      else
        render json: @volunteer.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /volunteers/1
  def update
    if @volunteer.update(volunteer_params)
      render json: @volunteer
    else
      render json: @volunteer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /volunteers/1
  def destroy
    @volunteer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_volunteer
      @volunteer = Volunteer.find(params[:id])
    end

    # REQUEST_ID GIVES AN ID TO USE TO CALL THE INDEX ACTION
    def set_id
      @request_id = Volunteer.find(params[:request_id])
    end

    # Only allow a trusted parameter "white list" through.
    def volunteer_params
      params.permit(:user_id, :request_id)
    end
end
