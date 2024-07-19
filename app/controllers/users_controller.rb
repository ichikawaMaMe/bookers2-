class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def new
    @books = Book.new
  end
  
  def show
    @user = User.find(params[:id])
    @books = Book.new
  end

def edit
  user = User.find(params[:id])
  unless user.id == current_user.id
    redirect_to user_path(current_user)
  end
  
  @user = User.find(params[:id])
end

  def create
    @books = Book.new(book_params)
    @books.user_id = current_user.id
    if @books.save
     flash[:notice] = "You have created book successfully."
     redirect_to book_path(@books)
    else
      flash.now[:error]
     render book_path(@books)
    end
  end

def update
  
  user = User.find(params[:id])
  unless user.id == current_user.id
    redirect_to user_path(current_user)
  end
  
  @user = User.find(params[:id])
  @user.update(user_params)
  if @user.save
    flash[:notice] = "You have updated user successfully"
   redirect_to user_path
  else
    flash.now[:error]
   render :edit
  end
end

def index
  @users = User.all
  @books = Book.new
end


private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      render :sign_in
    end
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
    end
  end
end
