class Admin::ContactsController < ApplicationController
  def index
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      redirect_to request.referer
    else
      @contact = Contact.find(params[:id])
      flash[:error] = "更新に失敗しました。もう一度お試しください。"
      render :show
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :name, :title, :body, :image, :is_support_status)
  end

end
