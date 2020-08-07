class ContactsController < ApplicationController
  def new
    # @new_contact = current_user
    # @new_contact = current_user.name
    # @new_contact = current_user.email
    @new_contact = Contact.new
  end

  def index
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def create
    @new_contact = Contact.new(contact_params)
    @new_contact.user = current_user
     if @new_contact.save(contact_params)
      redirect_to user_contacts_path
     else
      @user = User.find(params[:user_id])
      @new_contact = Contact.new(contact_params)
      flash[:error] = "お問い合わせに失敗しました。もう一度お試しください。"
      render :new
     end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :name, :title, :body, :image, :is_support_status)
  end


end
