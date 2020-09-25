class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :update, :destroy]
  before_action :set_id, only: [:index]

  # GET /chats
  def index
    @chats = Chat.all.where(request_id: @request_id)
    render json: @chats
  end

  # GET /chats/1
  def show
    render json: @chat
  end

  # POST /chats
  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      render json: @chat, status: :created
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chats/1
  def update
    if @chat.update(chat_params)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  def destroy
    @chat.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    # Allows to retrieve multiple chats for a single request using a request_id param
    def set_id
      @request_id = Chat.find(params[:request_id])
    end

    # Only allow a trusted parameter "white list" through.
    def chat_params
      params.permit(:user_id, :request_id, :volunteer_id)
    end
end
