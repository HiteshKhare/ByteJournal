# app/controllers/api/v1/application_controller.rb
class Api::V1::ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection

  protect_from_forgery with: :null_session
end
