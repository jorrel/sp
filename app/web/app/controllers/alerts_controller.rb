class AlertsController < ApplicationController
  before_filter :find_alert, :only => [:edit, :update, :destroy, :delete, :show]

  def index
    options = {:order => 'updated_at DESC'}

    @alerts = paginate :alerts, options
  end

  def new
    @alert = Alert.new
  end

  def update_form
    @alert = Alert.new(:target_type => params[:target_type])
    respond_to do |format|
      format.html { redirect_to :action => :index }
      format.js
    end
  end

  def create
    @alert = Alert.new(params[:alert])
    @alert.admin = current_admin
    @alert.save!
    flash[:notice] = "Alert for '#{@alert.target}' saved"
    redirect_to :action => :index
  end

  def update
    @alert.attributes = params[:alert]
    @alert.admin = current_admin
    @alert.save!
    flash[:notice] = "Alert for '#{@alert.target}' updated"
    redirect_to :action => :index
  end

  def destroy
    @alert.destroy
    flash[:notice] = "Alert for '#{@alert.target}' deleted"
    redirect_to :action => :index
  end

  private

    def find_alert
      @alert = Alert.find(params[:id])
    end
end
