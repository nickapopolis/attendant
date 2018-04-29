class ApplicationController < ActionController::Base
  # Prevent CSRF attacks, except for JSON requests (API clients)
  protect_from_forgery unless: -> { request.format.json? }

  # Require authentication and do not set a session cookie for JSON requests (API clients)
  before_action :authenticate_user!, :do_not_set_cookie, if: -> { request.format.json? }

  private
  # Do not generate a session or session ID cookie
  # See https://github.com/rack/rack/blob/master/lib/rack/session/abstract/id.rb#L171
  def do_not_set_cookie
    request.session_options[:skip] = true
  end
end
