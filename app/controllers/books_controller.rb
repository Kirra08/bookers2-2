class BooksController < ApplicationController
  before_action :ensure_book_user, only: [:update, :edit]

  def new
    @book = Book.new
  end 

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end
  
  def show
    @book_params = Book.find(params[:id])
    @user = User.find(@book_params.user_id)
    @book = Book.new
    @book_comment = BookComment.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.delete
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def ensure_book_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
