class RegistrationsController < ApplicationController
  
  def step1
  end 

  def step2
    @user = User.new
  end

  def step3
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
    # binding.pry
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
    @user.build_address(user_params[:address_attributes])


    if @user.save
      session[:id] = @user.id
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
      :address_firstname,
      :address_lastname,
      :address_firstname_kana,
      :address_lastname_kana,
      :prefecture_id,
      :postalcode,
      :city_name,
      :address_number,
      :building_name,
      :address_phone_number,
      ]
  )
  end
end






