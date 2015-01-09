class Front::BaseController < ApplicationController
  include FrontLayout # See /app/concerns/front_layout.rb

  layout "front_intern"

protected
  def nope
    return redirect_to front_home_path
  end
end
