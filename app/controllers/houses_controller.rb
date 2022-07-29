class HousesController < ApplicationController
  def index
    @houses = House.all
    render json: @houses
  end

  def show
    @house = House.find(params[:id])
    render json: @house
  end

  def new
    @house = House.new
  end

  def create
    @house = current_user.houses.new(house_params)

    if @house.save
      render json: @house, status: 201
    else
      render json: { errors: @house.errors.full_messages }, status: 422
    end
  end

  def edit
    @house = House.find(params[:id]) 
  end

  def update
    @house = House.find(params[:id])

    if @house.update(house_params)
      render json: @house, status: 204
    else
      render json: { errors: @house.errors.full_messages }, status: 304
    end
  end

  def destroy
    @house = House.find(params[:id]) 
    @house.destroy
    render json: @house, status: 200
  end

  def as_json(options = {})
    super(options.merge(include: :user))
  end

  private

  def house_params
    params.require(:house).permit(:street, :city)
  end

  def set_house
    @house = House.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end
end
