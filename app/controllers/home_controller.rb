class HomeController < ApplicationController
  skip_before_filter :ajax_only
 
  def home
  end

end
