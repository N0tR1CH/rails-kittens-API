# frozen_string_literal: true

class KittensController < ApplicationController
  before_action :set_kitten, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: [:index]

  def index
    @kittens = kittens
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
    @kitten = kittens.new(kitten_params)

    if @kitten.save
      render json: @kitten, status: 201
    else
      render json: { errors: @kitten.errors.full_messages }, status: 422
    end
  end

  def edit; end

  def update
    if @kitten.update(kitten_params)
      render json: @kitten, status: 204
    else
      render json: { errors: @kitten.errors.full_messages }, status: 304
    end
  end

  def destroy
    @kitten.destroy
    render json: @kitten, status: 200
  end

  def as_json(options = {})
    super(options.merge(include: :user))
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :house_id, :cuteness, :softness)
  end

  def set_kitten
    @kitten = Kitten.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  def kittens
    KittenPolicy::Scope.new(current_user, Kitten).resolve
  end
end
