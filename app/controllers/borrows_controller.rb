class BorrowsController < ApplicationController
  before_filter :authenticate

  def create
    current_user.borrow!(params[:borrow][:book_id])
    redirect_to "/"
  end
=begin      
      respond_to do |format|
            format.html { redirect_to '/' }
            format.js
      end
    end
=end


  def destroy
      book = Borrow.find(params[:id]).book
      current_user.unborrow!(book)
      redirect_to "/"
  end
=begin      
      respond_to do |format|
            format.html { redirect_to '/' }
            format.js
    end
=end   

  
end
