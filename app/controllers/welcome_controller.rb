# class WelcomeController < ApplicationController
class WelcomeController < ActionController::Base
  layout "application"

  def index
    # binding.pry_remote
    # render 'welcome/index'
    # render_to_string 'welcome/index'
  end
end
