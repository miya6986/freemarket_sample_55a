class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end

  private

  def callback_for(provider)
    oauth = request.env["omniauth.auth"]
    oauth_url = request.env["omniauth.origin"]
    uid = oauth.uid
    provider = oauth.provider
    snscredential = SnsCredential.find_by(uid: uid, provider: provider)
    if snscredential.present?
      user_sns = User.find(snscredential.user_id)
      user = User.find_by(email: oauth.info.email)
    end
    if user.present? && (oauth_url == new_user_session_url)
      if user_sns.present?
        sign_in_and_redirect user, event: :authentication and return
      else
        SnsCredential.create(
          uid: uid,
          provider: provider,
          user_id: user.id
          )
      end

      sign_in_and_redirect user, event: :authentication and return
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    elsif user.blank? && (oauth_url == step1_registrations_url)
      session[:nickname] = oauth.info.name
      session[:email] = oauth.info.email
      session[:password_token] = Devise.friendly_token[0, 20]
      session[:uid] = uid
      session[:provider] = provider
      redirect_to step2_registrations_path and return
    elsif user.present? && (oauth_url == step1_registrations_url)
      redirect_to root_path and return
    elsif user.blank? && (oauth_url == new_user_session_url)
      provider = 'google' if provider == 'google_oauth2'
      redirect_to new_user_session_url, flash: {no_record: "#{provider}での登録情報はありません。他の方法でログインをお試しください。"} and return
    end
  end

  def failure
    redirect_to root_path and return
  end
end
