class StudentsController < ApplicationController
  def index
    @students = Student.find(:all)
  end
end
