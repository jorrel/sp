class StudentsController < ApplicationController
  before_filter :find_student, :only => [:show, :edit, :delete, :destroy]
  before_filter :require_superadmin, :only => [:new, :create, :edit, :delete, :destroy]

  def index
    @students = Student.find(:all)
    @students = paginate :students, :order => 'updated_at DESC'
  end

  def new
    @student = Student.new
  end

  def show
  end

  def create
    @student = Student.new params[:student]
    @student.save!
    flash[:notice] = "Student record '#{@student.name}' saved"
    redirect_to :action => 'index'
  rescue ActiveRecord::RecordInvalid
    flash.now[:warning] = "This record cannot be saved because of invalid values"
    render :action => 'new'
  end

  def edit
  end

  def destroy
  end

  private

      def find_student
        @student = Student.find_by_student_id(params[:id])
        if not @student
          flash[:warning] = "No student found with id: #{params[:id]}"
          redirect_to '/students'
        end
      end
end
