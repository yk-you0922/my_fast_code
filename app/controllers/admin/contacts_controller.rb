class Admin::ContactsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @contacts = Contact.all.order(created_at: "DESC")
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      flash[:contacts_update] = "対応ステータスの更新が完了しました。"
      render :show
    else
      @contact = Contact.find(params[:id])
      render :show
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :name, :title, :body, :image, :is_support_status)
  end

end
