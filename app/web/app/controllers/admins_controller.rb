class AdminsController < AdministrationController
  before_filter :find_admin, :only => [:edit, :update, :delete, :destroy, :show]
  non_superadmin_action :index

  def index
    options = {:order => 'updated_at DESC'}
    if sort = ListSorting.extract_sort_field_from(params) and sort =~ /name/
      options[:joins] = 'JOIN personnels ON personnels.personnel_id = admins.personnel_id'
    end

    @admins = paginate :admins, options
  end

  def new
    @admin = Admin.new
  end

  def show
    redirect_to :action => :edit
  end

  def create
    @admin = Admin.new(params[:admin].except(:superadmin, :personnel_id))
    @admin.assign_protected_attributes(params[:admin])
    @admin.save!
    flash[:notice] = "Admin record '#{@admin.login}' saved"
    redirect_to :action => :index
  end

  def update
    @admin.attributes = params[:admin].except(:superadmin, :personnel_id)
    @admin.assign_protected_attributes(params[:admin])
    @admin.save!
    flash[:notice] = "Admin record '#{@admin.login}' updated"
    redirect_to :action => :index
  end

  def destroy
    @admin.destroy
    flash[:notice] = "Admin record '#{@admin.login}' deleted"
    redirect_to :action => :index
  end

  private

    def find_admin
      @admin = Admin.find(params[:id])
    end
end
