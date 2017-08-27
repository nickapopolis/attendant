class SessionsController < Devise::SessionsController

  def create
    user = warden.authenticate!(auth_options)
    token = Tiddle.create_and_return_token(user, request)

    if request.format.html?
      return redirect_to root_path
    end

    render json: { authentication_token: token }
  end

  def destroy
    Tiddle.expire_token(current_user, request) if current_user
    sign_out current_user

    if request.format.html?
      return redirect_to root_path
    end

    render json: {}
  end

  private
    # this is invoked before destroy and we have to override it
    def verify_signed_out_user

    end
end
