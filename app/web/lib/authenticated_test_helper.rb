module AuthenticatedTestHelper
  # Sets the current admin in the session from the admin fixtures.
  def login_as(admin)
    @request.session[:admin_id] = admin ? admins(admin).id : nil
  end

  def authorize_as(admin)
    @request.env["HTTP_AUTHORIZATION"] = admin ? ActionController::HttpAuthentication::Basic.encode_credentials(admins(admin).login, 'monkey') : nil
  end
  
end
