class SessionsController < ApplicationController

  require 'yaml'

  def create
    if credentials[params[:login]] && BCrypt::Password.new(credentials[params[:login]]) == params[:password]
      session[:admin] = params[:login]
      redirect_to root_path, notice: "Successfully signed in"
    else
      redirect_to root_path, alert: 'Invalid username or password'
    end
  end

  def destroy
    session.delete :admin
    redirect_to root_path, notice: 'Successfully signed out'
  end

  private

  # genreate new credentials with
  # BCrypt::Password.create('supersecret')
  # => "$2a$10$rpxN2dXLOOKsUyqU76m7IuTjWsrWyr67ARI1/833Cn3VKF1lKQflK"
  def credentials
    YAML.load_file 'config/credentials.yml'
  end

end