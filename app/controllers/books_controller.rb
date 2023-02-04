class BooksController < ApplicationController
  def index
    @book_new = Book.new 
    @books = Book.all
    @user = current_user
   
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
    @book_comments = @book.book_comments
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    unless @user == current_user
       redirect_to books_path
    end
    
  end
  
  def update
     @book = Book.find(params[:id])
      if @book.update(book_params)
      flash[:notice] = "Book was successfully updated!"
      redirect_to book_path(@book.id) 
      else
      render :edit
      end
  end
  
   def destroy
    @book = Book.find(params[:id])  
    @book.destroy
    flash[:notice] = "Book was successfully destroyed!"
    redirect_to books_path
   end
  
  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      flash[:notice] = "Book was successfully created!"
      redirect_to book_path(@book_new.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end
  
   private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end