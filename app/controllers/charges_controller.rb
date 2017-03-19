class ChargesController < ApplicationController
  before_action :authenticate_user!
  before_action :premium

  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: Amount.default,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    current_user.update_attribute(:role, 'premium')

    flash[:notice] = "Your payment has been received, #{current_user.email}. Thank you!"
    redirect_to user_path(current_user) # or wherever

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      current_user.update_attribute(:role, 'standard')
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

#  def index
#  end

#  def show
#  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.name}",
      amount: Amount.default
    }
  end

#  def edit
#  end

  # private
  #
  # def premium
  #   charge = Stripe::Charge(params[:id])
  #   unless current_user == current_user.standard?
  #     flash[:alert] = "Please pay for a premium account."
  #     redirect_to new_charge_path
  #   end
  # end
end
