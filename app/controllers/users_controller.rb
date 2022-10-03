# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.xml  { render :xml => @kittens }
    #   format.json { render :json => @kittens }
    # end
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    # render :json => Kitten.find(params[:id])
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.xml  { render :xml => @kitten }
    #   format.json { render :json => @kitten }
    # end
    render json: @User, serializer: UserSerializer
    render json: @user.roles.pluck(:name)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(kitten_params)

    if @user.save
      render json: @user, status: 201
    else
      render json: { errors: @user.errors.full_messages }, status: 422
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @User.update(user_params)
      render json: @user, status: 204
    else
      render json: { errors: @user.errors.full_messages }, status: 304
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: @user, status: 200
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end
end
