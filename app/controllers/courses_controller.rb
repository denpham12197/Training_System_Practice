class CoursesController < ApplicationController
  before_action :logged_in_user, only: [:member]
  def new
  end
  def index
    @courses = Course.paginate(page: params[:page])
  end
  def show
    @course = Course.find_by(id: params[:id])
    @users = User.joins(:user_courses).where(:user_courses => {course_id: params[:id]}).where(:users => {supervisor: false})
    @user = User.joins(:user_courses).where(:user_courses => {course_id: params[:id]}).where(:users => {supervisor: true})
    @subjects = Subject.joins(:course).where(:courses => {id: params[:id]})
  end

  def member
    @members= User.joins(:user_courses).where(:user_courses => {course_id: params[:id]}).where(:users => {supervisor: false})
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
