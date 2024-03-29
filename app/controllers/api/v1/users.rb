module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults
      
      resource :users do        
        desc "Return user authenticated by JWT"
        get "me" do
          authenticate!
          @current_user
        end
      end
    end
  end
end
