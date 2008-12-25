class InfoController < ApplicationController
  skip_before_filter :ajax_only
 
  def home
  end

  def info
    render :layout => false    
  end

end
