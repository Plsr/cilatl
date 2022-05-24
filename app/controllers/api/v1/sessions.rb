module API
  module V1
    class Sessions < Grape::API
      include API::V1::Defaults
      include API::V1::JsonWebToken

      resource :sessions do
        desc "Create a new session"
        params do
          requires :email, type: String, desc: "User email", documentation: { param_type: 'body' }
          requires :password, type: String, desc: "User password", documentation: { param_type: 'body' }
        end
        post "" do
          user = User.authenticate(params[:email], params[:password])
          error!(message: 'wrong email or password', status: 403) unless user.present?
          token = jwt_encode({ user_id: user.id })
          { user: user.email, token: token }
        end
      end
    end
  end
end
