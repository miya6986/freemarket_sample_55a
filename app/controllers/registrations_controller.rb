class RegistrationsController < ApplicationController
  
  before_action :validates_step2, only: :step3
  before_action :validates_step3, only: :step4

  def step1
  end 

  def step2
    if session[:nickname] && session[:email]
      @user = User.new(
        nickname: session[:nickname],
        email: session[:email],
      )
    else
      @user = User.new
    end
  end

  def step3
    session_assignment(user_params)
    @user = User.new
  end

  def step4
    session[:phone_number] = user_params[:phone_number]
    @user = User.new
    @user.build_address
  end

  def step5
  end

  def step6
  end

  def login
  end

  def create
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      firstname: session[:firstname],
      lastname:session[:lastname],
      firstname_kana: session[:firstname_kana],
      lastname_kana: session[:lastname_kana],
      birth_year: session[:birth_year],
      birth_month: session[:birth_month],
      birth_day: session[:birth_day],
      phone_number: session[:phone_number]
    )
    @user.build_address(user_params[:address_attributes])


    if @user.save(context: :registrations)
      session[:id] = @user.id
      sign_in(@user)
      redirect_to step5_registrations_path
    else
      redirect_to step2_registrations_path
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :nickname, 
      :email,
      :password,
      :password_confirmation,
      :firstname,
      :lastname,
      :lastname_kana,
      :firstname_kana,
      :birth_year,
      :birth_month,
      :birth_day,
      :phone_number,

      address_attributes: [
      :id,
      :firstname,
      :lastname,
      :firstname_kana,
      :lastname_kana,
      :prefecture_id,
      :postalcode,
      :city_name,
      :address_number,
      :building_name,
      :phone_number,
      ]
    )
  end

  def session_assignment(user_params)
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password] 
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:firstname] = user_params[:firstname]
    session[:lastname] = user_params[:lastname]
    session[:firstname_kana] = user_params[:firstname_kana]
    session[:lastname_kana] = user_params[:lastname_kana]
    session[:birth_year] = user_params[:birth_year]
    session[:birth_month] = user_params[:birth_month]
    session[:birth_day] = user_params[:birth_day]
  end

  def validates_step2
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:firstname] = user_params[:firstname]
    session[:lastname] = user_params[:lastname]
    session[:firstname_kana] = user_params[:firstname_kana]
    session[:lastname_kana] = user_params[:lastname_kana]
    session[:birth_year] = user_params[:birth_year]
    session[:birth_month] = user_params[:birth_month]
    session[:birth_day] = user_params[:birth_day]
    
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      firstname: session[:firstname],
      lastname:session[:lastname],
      firstname_kana: session[:firstname_kana],
      lastname_kana: session[:lastname_kana],
      birth_year: session[:birth_year],
      birth_month: session[:birth_month],
      birth_day: session[:birth_day],
    )
    
    render '/registrations/step2' unless @user.valid?
  end

  def validates_step3
    session[:phone_number] = user_params[:phone_number]

    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation],
      firstname: session[:firstname],
      lastname:session[:lastname],
      firstname_kana: session[:firstname_kana],
      lastname_kana: session[:lastname_kana],
      birth_year: session[:birth_year],
      birth_month: session[:birth_month],
      birth_day: session[:birth_day],
      phone_number: session[:phone_number],
    )
    render '/registrations/step3' unless @user.valid?(:registrations)
  end
end
