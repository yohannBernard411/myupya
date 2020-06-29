class OrdersController < ApplicationController

  def create
    date = params[:date]
    coach = Coach.find(params[:coach_id])
    order  = Order.create!(coach: coach, amount: coach.price, state: 'pending', user: current_user, date: date)
  
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: coach.email,
        images: [coach.photo_url],
        amount: coach.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )
  
    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end

  def show
    @order = current_user.orders.find(params[:id])
    months = ["Janvier", "Fevrier", "Mars", "Avril", "Mai", "Juin", "Juillet", "Aout", "Septembre", "Octobre", "Novembre", "Decembre"]
    @month = months[@order.date.split("-")[1].to_i - 1]
  end


end
