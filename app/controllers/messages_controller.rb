class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]
  before_action :set_id, only: [:index]

  # GET /messages
  def total
    all_messages = Message.all
    render json: all_messages
  end

  # DELETE /messages
  def remove_all
    all_messages = Message.all
    all_messages._destroy_all
    render json: {success: "All messages have been removed from the Message table."}
  end

  def index
    @messages = Message.all.where(chat_id: @chat_id)
    render json: @messages
  end

  # POST /messages
  def create
    @message = Message.new(message_params)

    if @message.save
      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    def set_id
      @chat_id = Chat.find(params[:chat_id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.permit(:chat_id, :user_id, :author, :content)
    end
end
