class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request

    @contact.user = Passenger.find(params[:id]).events.published.last.user.email
    Rails.logger.debug("DEBUG self pssgrs: #{@contact.user}")
    Rails.logger.debug("DEBUG id: #{params[:id]}")

    if @contact.deliver
  #    flash.now[:error] = nil
  #redirect_to root_path, notice: 'Message sent successfully'
  redirect_to passenger_path( id: params[:id]), :notice => "message fine a traduire"
    else
      #flash.now[:error] = 'Cannot send message'
      #render :new
      #redirect_to passenger_url(params[:id]), alert: 'Merci de remplir tous les champs'
      #redirect_to passenger_url(params[:id]), alert: @contact.errors.full_messages
      redirect_to passenger_url(params[:id]), alert: @contact.errors.full_messages.join(', ')
      Rails.logger.debug("DEBUG id: #{@contact.errors.full_messages}")

    end
  end

end
