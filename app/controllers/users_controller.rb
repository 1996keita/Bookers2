class UsersController < ApplicationController

before_action :authenticate_user!,except: [:top]

before_action :move_to_signed_in

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @user_books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    unless @user.id==current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] =  "You have updated book successfully"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
 def index
   @users = User.all
   @user = current_user
   @book = Book.new
 end
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  def move_to_signed_in
    unless user_signed_in?
      redirect_to  '/users/sigh_in'
    end
  end

end


