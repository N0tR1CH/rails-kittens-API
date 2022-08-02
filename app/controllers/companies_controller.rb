class CompaniesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index
    @companies = companies
    
    render json: @companies
  end

  def show
    render json: @companies, serializer: CompanySerializer
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

  def user_new
    @company.user = User.new
  end

  def edit
    
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
    rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  def companies
    CompanyPolicy::Scope.new(current_user, Company).resolve
  end
end
