class CarsController < ApplicationController
  include ErrorsHelper

  def index; end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(permitted_params.except(:seller))
    assign_seller!
    unless @car.save
      flash.now[:alert] = t("cars.save_failed", errors: format_flash_errors(@car.errors.full_messages))
      render :new
      return
    end
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
    @car.seller = User.find_or_build_by(permitted_params[:seller])
  end
end
