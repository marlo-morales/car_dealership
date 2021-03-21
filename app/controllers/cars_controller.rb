class CarsController < ApplicationController
  include ErrorsHelper

  before_action :fetch_car, :authorize_car, only: %i(edit update destroy)

  def index
    cars = Car.recent.includes(:seller)
    @cars = Kaminari.paginate_array(filter(cars)).page(params[:page]).per(10)
  end

  def new
    @car = Car.new
    if current_user
      assign_seller!
      authorize_car
    end
  end

  def create
    @car = Car.new(permitted_params.except(:seller))
    assign_seller!
    authorize_car if current_user
    unless @car.save
      flash.now[:alert] = t("cars.save_failed", errors: format_flash_errors(@car.errors.full_messages))
      render :new
      return
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def permitted_params
    permitted = params.require(:car).permit(
      :make, :model, :year, :condition, :price,
      seller: %i(name mobile_number email)
    )
    permitted[:condition] = permitted[:condition].to_i if permitted[:condition]
    permitted.permit!
  end

  def assign_seller!
    return @car.seller = current_user if current_user

    @car.seller = User.find_or_build_by(permitted_params[:seller])
  end

  def filter(cars)
    cars = cars.where("LOWER(make) = ?", params[:make]&.downcase) if params[:make].present?
    cars = cars.where(year: params[:year]) if params[:year].present?
    cars
  end

  def fetch_car
    @car = Car.find(params[:id])
  end

  def authorize_car
    authorize @car, "#{action_name}?"
  end
end
