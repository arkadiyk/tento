class AccountController < ApplicationController
  def show
    op = params[:p1]
    case op 
      when 'login'
        render :template => 'sessions/new'
      when 'signup'
        @user = User.new
        render  :template => 'users/new'
      else
        if !logged_in?
          render :template => 'sessions/new'
        end      
    end
  end

end
