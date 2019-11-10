class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_for(:facebook)
  end

  def google_oauth2
    callback_for(:google)
  end

  def callback_for(provider)
    aouth = request.env["omniauth.auth"]
    uid = aouth.uid
    provider = aouth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first

    if snscredential.present?
      @user_sns = User.where(id: snscredential.user_id).first
    else
      @user = User.where(email: auth.info.email).first
    end

    if @user.present? && (request.refeler == login_path)
      if @user_sns.present?
        sign_in_and_redirect @user, event: :authentication
      end
      SnsCredential.create(
        uid: uid,
        provider: provider,
        user_id: user.id
        )

      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?

    elsif @user.blank? && (request.refeler == step1_registration_path)
      session[:nickname] = oauth.info.name
      session[:email] = oauth.info.email
      session[:password] = Devise.friendly_token[0, 20]
      session[:uid] = uid
      session[:provider] = provider
      redirect_to step2_registration_path

    elsif @user.present? && (request.refeler == step1_registration_path)
      notice: "ユーザーは既に存在しています"
      redirect_to root_path

    elsif @user.blank? && (request.refeler == login_path)
      nogice: "ユーザーは存在しません"
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path and return
  end
end
