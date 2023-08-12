class CheckoutsController < ApplicationController
    before_action :authenticate_user!

    def show
        current_user.set_payment_processor :stripe
        current_user.payment_processor.customer
    
        # Get the selected subscription plan ID from params (e.g., 'price_abc123').
        subscription_plan_id = params[:subscription_plan_id]
    
        @checkout_session = current_user
          .payment_processor
          .checkout(
            mode: 'subscription',
            line_items: subscription_plan_id,
            success_url: checkout_success_url,
          )
      end

    def success    
        @session = Stripe::Checkout::Session.retrieve(params[:session_id])
        @line_items = Stripe::Checkout::Session.list_line_items(params[:session_id])
        current_user.update(subscription: @line_items.first.description)
    end
end
