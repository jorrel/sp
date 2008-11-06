class AdminsController < AdministrationController
  before_filter :find_admin, :only => [:edit, :update, :delete, :destroy, :show]

  def index
    options = {:order => 'updated_at DESC'}
    options[:joins] = 'JOIN personnels ON personnels.personnel_id = admins.personnel_id' if params[:sort] and params[:sort] =~ /name/
    @admins = paginate :admins, options
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params[:admin].except(:superadmin, :personnel_id))
    @admin.assign_protected_attributes(params[:admin])
    @admin.save!
    flash[:notice] = "Admin record '#{@admin.login}' saved"
    redirect_to :action => 'index'
  rescue ActiveRecord::RecordInvalid
    flash.now[:warning] = "This record cannot be saved because of invalid values"
    render :action => 'new'
  end

  def update
    @admin.attributes = params[:admin].except(:superadmin, :personnel_id)
    @admin.assign_protected_attributes(params[:admin])
    @admin.save!
    flash[:notice] = "Admin record '#{@admin.login}' updated"
    redirect_to :action => 'index'
  rescue ActiveRecord::RecordInvalid
    flash.now[:warning] = "The record cannot be updated because of invalid values"
    render :action => 'edit'
  end

  def destroy
    @admin.destroy
    flash[:notice] = "Admin record '#{@admin.login}' deleted"
    redirect_to :action => 'index'
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

    def find_admin
      @admin = Admin.find(params[:id])
    end
end
