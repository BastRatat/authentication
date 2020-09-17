class UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # POST /users
  def create
    @user = User.new(user_params)
    begin
      if @user.save!
        token = encode_token({
          user_id: @user.id,
          email: @user.email,
          first_name: @user.first_name,
          last_name: @user.last_name
        })
        render json: {user: @user, token: token}
      else
        render json: {error: "Invalid email or password"}
      end
    rescue PG::UniqueViolation
      render json: {error: "Email already signed up"}
    end

  end

  def show
    render json: @user
  end

  def login
    @user = User.find_by(email: params[:email])

    begin
      if @user && @user.authenticate(params[:password])
        token = encode_token({
          user_id: @user.id,
          email: @user.email,
          first_name: @user.first_name,
          last_name: @user.last_name
        })
        render json: {user: @user, token: token}
      else
        render json: {error: "Invalid email or password"}
      end
    rescue PG::UniqueViolation
      render json: {error: "An issue has occured"}
    end
  end

  def auto_login
    render json: @user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
