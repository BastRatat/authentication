class PapersController < ApplicationController
  before_action :set_paper, only: [:show, :destroy]

  def index
    @papers = Paper.all
    render json: @papers
  end

  def show
    render json: @paper
  end

  # POST /papers
  def create
    @paper = Paper.new(paper_params)

    if @paper.save
      render json: @paper, status: :created
    else
      render json: @paper.errors, status: :unprocessable_entity
    end
  end

  # DELETE /papers/1
  def destroy
    @paper.destroy
    render json: {'success': 'File was removed.'}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paper
      @paper = Paper.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def paper_params
      params.permit(:user_id, :official)
    end
end
