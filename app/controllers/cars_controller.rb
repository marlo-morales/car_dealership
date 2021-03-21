class CarsController < ApplicationController
  before_action :fetch_car, :authorize_car, except: %i(index new create)

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
    if @car.save
      redirect_to thank_you_car_path(@car)
    else
      flash.now[:alert] = t("cars.save.failed", errors: format_flash_errors(@car.errors.full_messages))
      render :new
    end
  end

  def edit; end

  def update
    if @car.update(permitted_params.except(:seller))
      redirect_to root_path, notice: t("cars.save.success", title: @car.title, action: :updated)
    else
      flash.now[:alert] = t("cars.save.failed", errors: format_flash_errors(@car.errors.full_messages))
      render :edit
    end
  end

  def destroy
    title = @car.title
    @car.destroy
    redirect_to request.referrer || root_path, notice: t("cars.save.success", title: title, action: :deleted)
  end

  def buy; end

  def sold
    assign_buyer!
    if @car.save
      redirect_to thank_you_car_path(@car)
    else
      flash.now[:alert] = t("cars.buy.failed", errors: format_flash_errors(@car.errors.full_messages))
      render :buy
    end
  end

  def unsold
  end

  def thank_you
    if @car.sold?
      @admin = User.find_by(admin: true)
      CarMailer.with(car_id: @car.id, email: @admin.email).send_sold_email.deliver_later unless @car.sent_sold_email?
    end
  end

  private

  def fetch_car
    @car = Car.find(params[:id])
  end

  def authorize_car
    authorize @car, "#{action_name}?"
  end

  def permitted_params
    permitted = params.require(:car).permit(
      :make, :model, :year, :condition, :price, seller: %i(name mobile_number email)
    )
    permitted[:condition] = permitted[:condition].to_i if permitted[:condition]
    permitted.permit!
  end

  def sold_permitted_params
    params.require(:car).permit(buyer: %i(name mobile_number email))
  end

  def assign_seller!
    return @car.seller = current_user if current_user

    @car.seller = User.find_or_build_by(permitted_params[:seller])
  end

  def assign_buyer!(unset: false)
    return @car.buyer_id = nil if unset
    return @car.buyer = current_user if current_user

    @car.validate_buyer = true
    @car.buyer = User.find_or_build_by(sold_permitted_params[:buyer])
  end

  def filter(cars)
    cars = cars.where("LOWER(make) = ?", params[:make]&.downcase) if params[:make].present?
    cars = cars.where(year: params[:year]) if params[:year].present?
    cars = cars.where(seller_id: current_user.id) if params[:owned] == "1"
    cars
  end
end
