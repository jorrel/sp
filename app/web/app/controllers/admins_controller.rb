class AdminsController < AdministrationController
  def index
    @admins = Admin.paginate :page => params[:page] || 1, :order => 'updated_at DESC'
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params[:admin].except(:superadmin, :personnel_id))
    assign_protected_attributes
    @admin.save!
    flash[:notice] = "Admin record '#{@admin.login}' saved"
    redirect_to :action => 'index'
  rescue ActiveRecord::RecordInvalid
    flash.now[:warning] = "This record cannot be saved because of invalid values"
    render :action => 'new'
  end

#   def create
#     logout_keeping_session!
#     @admin = Admin.new(params[:admin])
#     success = @admin && @admin.save
#     if success && @admin.errors.empty?
#             # Protects against session fixation attacks, causes request forgery
#       # protection if visitor resubmits an earlier form using back
#       # button. Uncomment if you understand the tradeoffs.
#       # reset session
#       self.current_admin = @admin # !! now logged in
#       redirect_back_or_default('/')
#       flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
#     else
#       flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
#       render :action => 'new'
#     end
#   end

    private

      def assign_protected_attributes
        @admin.superadmin = params[:admin][:superadmin]
        @admin.personnel_id = params[:admin][:personnel_id]
      end
end
