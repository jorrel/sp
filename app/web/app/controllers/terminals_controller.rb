class TerminalsController < ApplicationController
  before_filter :find_terminal, :only => [:edit, :update, :delete, :destroy, :show]

  def index
    @terminals = paginate :terminals, :order => 'updated_at DESC'
  end

  def new
    @terminal = Terminal.new
  end

  def create
    @terminal = Terminal.new(params[:terminal])
    @terminal.save!
    flash[:notice] = "Terminal record #{@terminal.name} saved"
    redirect_to :action => 'index'
  rescue ActiveRecord::RecordInvalid
    flash.now[:warning] = "This record cannot be saved because of invalid values"
    render :action => 'new'
  end

  def destroy
    @terminal.destroy
    flash[:notice] = "Admin record '#{@terminal.name}' deleted"
    redirect_to :action => 'index'
  end

  private

    def find_terminal
      @terminal = Terminal.find(params[:id])
    end
end
