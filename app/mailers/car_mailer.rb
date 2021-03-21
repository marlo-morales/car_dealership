# frozen_string_literal: true

class CarMailer < ApplicationMailer
  before_action :fetch_car
  after_action :sent_sold_email!, only: :send_sold_email

  def send_sold_email
    mail(
      from: "no-reply@example.org",
      to: params[:email],
      subject: t("cars.mailer.send_sold_email.subject", title: @car.title, buyer: @car.buyer.name)
    )
  end

  private

  def fetch_car
    @car = Car.find(params[:car_id])
  end

  def sent_sold_email!
    @car.update(sent_sold_email_at: DateTime.current)
  end
end
