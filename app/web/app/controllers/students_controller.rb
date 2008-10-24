class StudentsController < ApplicationController
  before_filter :find_student, :only => [:show, :edit, :destroy]

  def index
    @students = Student.find(:all)
  end

  def new
    @student = Student.new
  end

  def show
  end

  def create
    @student = Student.create! params[:student]
  rescue ActiveRecord::RecordInvalid
    flash[:warning] = 'Invalid Record'
    render :action => 'new'
  else
    flash[:success] = 'New Student created'
    redirect_to student_path(@student)
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
