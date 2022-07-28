class KittensController < ApplicationController
  before_action :set_kitten, only: [:show]
  before_action :authenticate_user!
  
  def index
    @kittens = Kitten.all
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.xml  { render :xml => @kittens }
    #   format.json { render :json => @kittens }
    # end
    render json: @kittens
  end

  def show
    # render :json => Kitten.find(params[:id]) 
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.xml  { render :xml => @kitten }
    #   format.json { render :json => @kitten }
    # end
    render json: @kitten, serializer: KittenSerializer
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      render json: @kitten, status: 201
    else
      render json: { errors: @kitten.errors.full_messages }, status: 422
    end
  end

  def edit
    @kitten = Kitten.find(params[:id]) 
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      render json: @kitten, status: 204
    else
      render json: { errors: @kitten.errors.full_messages }, status: 304
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id]) 
    @kitten.destroy
    render json: @kitten, status: 200
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end

  def set_kitten
    @kitten = Kitten.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end
end
