class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show, :index, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :supervisor_user,only: :destroy

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def index
    if (current_user.supervisor == true)
    @users = User.all
    elsif (current_user.supervisor == false)
    @users = User.where(supervisor: false)
    end
  end

#def show
#  return if @user = User.find_by(id: params[:id])
#  flash[:danger] = t "user_not_found"
#  redirect_to root_url
#end
  def show
    @user = User.find_by(id: params[:id])
    @course = Course.joins(:user_courses).where(:user_courses => {user_id: params[:id]})
  end

  def edit
    @user = User.find_by(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = t "hello"
      redirect_to root_url
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :email, :password,
      :password_confirmation
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def supervisor_user
    redirect_to(root_url) unless current_user.supervisor?
  end
end
