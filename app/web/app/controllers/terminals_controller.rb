class TerminalsController < AdministrationController
  before_filter :find_terminal, :only => [:edit, :update, :delete, :destroy, :show]
  non_superadmin_action :index

  def index
    @terminals = paginate :terminals, :order => 'updated_at DESC'
  end

  def new
    @terminal = Terminal.new
  end

  def show
    redirect_to :action => :edit
  end

  def create
    @terminal = Terminal.new(params[:terminal])
    @terminal.save!
    flash[:notice] = "Terminal record #{@terminal.name} saved"
    redirect_to :action => :index
  end

  def update
    @terminal.attributes = params[:terminal]
    @terminal.save!
    flash[:notice] = "Admin record '#{@terminal.name}' updated"
    redirect_to :action => :index
  end

  def destroy
    @terminal.destroy
    flash[:notice] = "Admin record '#{@terminal.name}' deleted"
    redirect_to :action => :index
  end

  private

    def find_terminal
      @terminal = Terminal.find(params[:id])
    end
end
