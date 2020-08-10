class Admin::ContactsController < ApplicationController
  def index
    @contacts = Contact.all.order(created_at: "DESC")
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact.update(contact_params)
      redirect_to admin_contacts_path
      flash[:contacts_update] = "対応ステータスの更新が完了しました。"
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
