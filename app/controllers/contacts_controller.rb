class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.user = Passenger.friendly.find(params[:id]).events.published.last.user.email
    @contact.request = request

    # TODO: redirect to homepage
    if @contact.deliver
      redirect_to passenger_path(id: params[:id]), notice: t(:message_sent)
    else
      redirect_to passenger_url(params[:id]), alert: @contact.errors.full_messages.join(', ')

    end
  end
end
