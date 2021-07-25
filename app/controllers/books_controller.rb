class BooksController < ApplicationController
 before_action :authenticate_user!
 before_action :correct_book, only: [:edit, :update]

 def create
      @book = Book.new(book_params)
      @book.user_id = current_user.id
     if @book.save
      flash[:notice] = "successfully"
      redirect_to  book_path(@book)
     else
      @user = current_user
      @books = Book.all
      render :index
     end
 end

 def index
      @user = current_user
      @books = Book.all
      @book = Book.new
 end

 def show
      @showbook = Book.find(params[:id])
      @user = @showbook.user
      @book = Book.new
 end


 def update
     @book = Book.find(params[:id])
     @book.update(book_params)
    if @book.save
     flash[:notice] = "successfully"
     redirect_to book_path(@book.id)
    else
     @user = current_user
     @books = Book.all
     render :edit
    end
 end

 def destroy
     book = Book.find(params[:id])
     book.destroy

     redirect_to '/books'
 end

 def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
       render "edit"
    else
       redirect_to books_path
    end

 end

 private
  # ストロングパラメータ
 def book_params
    params.require(:book).permit(:title, :body)
 end

  def correct_book
    @book = Book.find(params[:id])
    if current_user != @book.user
       redirect_to books_path
    end
  end


end
