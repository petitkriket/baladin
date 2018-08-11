class ContactsController < ApplicationController

  def new
    @contact = Contact.new
    Rails.logger.debug("DEBUG 1: #{@event.user_id}")

  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    Rails.logger.debug("DEBUG 2: #{@event}")
    Rails.logger.debug("DEBUG 3: #{self}")
    Rails.logger.debug("DEBUG 3: #{@contact.user}")

    #self.user_id =
    if @contact.deliver
  #    flash.now[:error] = nil
  redirect_to root_path, notice: 'Message sent successfully'
  #redirect_to passenger_url, notice: 'Message sent successfully'
    else
  #    flash.now[:error] = 'Cannot send message'
      render :new
    end
  end

end
