class WelcomeController < ApplicationController

  skip_authorization_check

  def index
  end
  def about
  end
  def contact
  end
  def investors
  end
  def legal
  end
  def brokers
  end

  def access_code
    if access_code = AccessCode.find_by(code: params[:access_code])
      session[:access_code] = access_code.id
      flash[:notice] = t('access_code.valid')
      redirect_to new_user_registration_path
    else
      flash[:error] = t('access_code.invalid')
      redirect_to unauthenticated_root_path
    end
  end

  def mailing_list
    if MailingList.exists?(email: params[:email])
      flash[:notice] = t('mailing_list.thanks_for_the_interest')
    else
      @user = MailingList.create(email: params[:email])
      if @user.persisted?
        flash[:notice] = t('mailing_list.success')
      else
        flash[:error] = t('mailing_list.failure', error: @user.errors.full_messages_for(:email).first)
      end
    end

    redirect_to unauthenticated_root_path
  end

  def send_email
    c = ContactForm.new(
        name: params[:name],
        message: params[:message],
        email: params[:email],
        subject: params[:subject]
    )

    c.deliver

    flash[:notice] = t('contact.success')

    redirect_to unauthenticated_root_path
  end
end
