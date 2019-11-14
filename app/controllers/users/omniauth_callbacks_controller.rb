class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # facebookのコールバック関数
  def facebook
    callback_for(:facebook)
  end
  # googleのコールバック関数
  def google_oauth2
    callback_for(:google)
  end

  private
  # コールバック関数の実処理
  def callback_for(provider)
    # SNSのユーザーデータを代入
    oauth = request.env["omniauth.auth"]
    # SNS認証呼び出し元アドレスの代入（step1かdevise/session/new）
    oauth_url = request.env["omniauth.origin"]
    uid = oauth.uid
    snscredential = SnsCredential.find_by(uid: uid, provider: provider)
    # 既にsns_credentialsにテーブルがあれば取得
    if snscredential.present?
      user_sns = User.find(snscredential.user_id)
      user = User.find_by(email: oauth.info.email)
    end
    # 呼び出し元のアドレスとUser,SnsCredentialsの存在で場合分け
    # ログイン画面でUserが既に存在する場合、SnsCredentialsも既に存在するならそのままログイン
    if user.present? && (oauth_url == new_user_session_url)
      if user_sns.present?
        sign_in_and_redirect user, event: :authentication and return
      else
        # Userが存在し、対応するSnsCredentialsが存在しない場合はSnsCredentialsをcreate、その後ログイン
        SnsCredential.create(
          uid: uid,
          provider: provider,
          user_id: user.id
          )
      end

      sign_in_and_redirect user, event: :authentication and return
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    # 新規登録画面でUserがなければsessionを作成しstep2に進める
    elsif user.blank? && (oauth_url == step1_registrations_url)
      session[:nickname] = oauth.info.name
      session[:email] = oauth.info.email
      session[:password_token] = Devise.friendly_token[0, 20]
      session[:uid] = uid
      session[:provider] = provider
      redirect_to step2_registrations_path and return
    # 新規登録画面でUserが存在していればroot_pathに飛ばす
    elsif user.present? && (oauth_url == step1_registrations_url)
      redirect_to root_path and return
    # ログイン画面でUserが存在しなければroot_pathに戻す
    elsif user.blank? && (oauth_url == new_user_session_url)
      redirect_to root_path and return
    end
  end
# 認証エラー時にはrootに戻る
  def failure
    redirect_to root_path and return
  end
end
