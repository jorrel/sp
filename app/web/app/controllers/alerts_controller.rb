class AlertsController < ApplicationController
  before_filter :find_alert, :only => [:edit, :update, :destroy, :delete, :show]

  def index
    @alerts = paginate :alerts, :order => 'updated_at DESC'
    fresh_when :etag => @alerts.first, :last_modified => @alerts.first.updated_at.utc if @alerts.first
  end

  def new
    @alert = Alert.new

    if last_student_modified = Student.recent
      fresh_when :etag => @alert, :last_modified => last_student_modified.updated_at.utc
    end
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

  def by_admin
    @admin = params[:login] ? Admin.find_by_login(params[:login]) : current_admin
    redirect_to :action => :index unless @admin
    @alerts = paginate @admin.alerts, :order => 'updated_at DESC'
  end

  private

    def find_alert
      @alert = Alert.find(params[:id])
    end
end
