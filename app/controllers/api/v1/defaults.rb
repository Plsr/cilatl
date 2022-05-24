module API
  module V1
    module Defaults
      extend ActiveSupport::Concern
      include JsonWebToken
      
      included do
        prefix "api"
        version "v1", using: :path
        default_format :json
        format :json
        formatter :json, Grape::Formatter::ActiveModelSerializers
        
        helpers do
          def permitted_params
            @permitted_params ||= declared(params, include_missing: false)
          end
          
          def logger
            Rails.logger
          end

          def authenticate!
            auth_token = headers["Authorization"]&.gsub('Bearer ', '')
            user_id = jwt_decode(auth_token)[:user_id]
            @current_user = User.find(user_id)
          end
        end
          
        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end
        
        rescue_from ActiveRecord::RecordInvalid do |e|
          error_response(message: e.message, status: 422)
        end

        rescue_from JWT::VerificationError do |e|
          error_response(message: 'Invalid Bearer token', status: 403)
        end

        rescue_from JWT::DecodeError do |e|
          error_response(message: 'Bearer token is required', status: 400)
        end
      end
    end
  end
end
