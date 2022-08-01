class HousesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_house, only: [:show, :edit, :update, :destroy]

  def index
    @houses = houses
    
    render json: @houses
  end

  def show
    render json: @house, serializer: HouseSerializer
  end

  def new
    @house = House.new
  end

  def create
    @house = current_user.houses.new(house_params)
    authorize @house
    if @house.save
      current_user.add_role :creator, @house
      render json: @house, status: 201
    else
      render json: { errors: @house.errors.full_messages }, status: 422
    end
  end

  def edit
    
  end

  def update
    if @house.update(house_params)
      current_user.add_role :editor, @house
      render json: @house, status: 204
    else
      render json: { errors: @house.errors.full_messages }, status: 304
    end
  end

  def destroy
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
    rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  def houses
    HousePolicy::Scope.new(current_user, House).resolve
  end
end
