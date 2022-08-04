class CompaniesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_company, only: [:show, :edit, :update, :destroy, :add_user]

  def index
    @companies = companies
    render json: @companies
  end

  def show
    render json: @company, serializer: CompanySerializer
  end

  def new
    @company = Company.new
  end

  def create
    @company = current_user.companies.new(company_params)
    if @company.save
      current_user.add_role :creator, @company
      render json: @company, status: 201
    else
      render json: { errors: @company.errors.full_messages }, status: 422
    end
  end

  def edit; end

  def add_user
    ActiveRecord::Base.transaction do
      @company.users << User.where(id: params[:user_ids])
      render json: @company, status: 200
    rescue ActiveRecord::RecordInvalid
      render json: { message: 'One of the users is already in the company.' } 
    end
  end

  def update
    if @company.update(company_params)
      current_user.add_role :editor, @company
      render json: @company, status: 204
    else
      render json: { errors: @company.errors.full_messages }, status: 304
    end
  end

  def destroy
    @company.destroy
    render json: @company, status: 200
  end

  def as_json(options = {})
    super(options.merge(include: :user))
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end

  def set_company
    @company = Company.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  def companies
    CompanyPolicy::Scope.new(current_user, Company).resolve
  end
end
