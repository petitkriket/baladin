class ContactsController < ApplicationController

  def new
    @contact = Contact.new
    Rails.logger.debug("DEBUG 1: #{@event.user_id}")

  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request

    @contact.user = Passenger.find(params[:id]).events.published.last.user.email
    Rails.logger.debug("DEBUG self pssgrs: #{@contact.user}")
    Rails.logger.debug("DEBUG id: #{params[:id]}")

    #self.user_id =
    if @contact.deliver
  #    flash.now[:error] = nil
  redirect_to root_path, notice: 'Message sent successfully'
  #redirect_to passenger_url, notice: 'Message sent successfully'
    else
      #flash.now[:error] = 'Cannot send message'
      #render :new
      redirect_to passenger_url(params[:id]), alert: 'nazzzzz'
    end
  end

end
