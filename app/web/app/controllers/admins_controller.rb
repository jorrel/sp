class AdminsController < AdministrationController
  before_filter :find_admin, :only => [:edit, :update, :delete, :destroy, :show]

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

  private

    def find_admin
      @admin = Admin.find(params[:id])
    end
end
