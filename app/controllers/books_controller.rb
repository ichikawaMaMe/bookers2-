class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def new
    @book = Book.new
  end
  
  def index
    @users = User.all
    @books = Book.all
    @book = Book.new
  end

  def edit
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
    redirect_to books_path
    end
    @book = Book.find(params[:id])
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
     flash[:notice] = "You have created book successfully."
     redirect_to book_path(@book)
    else
      @users = User.all
      @books = Book.all
     render :index
    end
  end


  def update
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
    redirect_to books_path
    end
    
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
      flash[:notice] = "You have update book successfully."
      redirect_to @book
    else
    @books = Book.all
    flash.now[:error] ="更新に失敗しました。"
    render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "You have destroy book successfully."
    redirect_to books_path
  end
  
 private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
    end
  end

end

