class StudentsController < ApplicationController

  before_action :set_student, only: %i[ show edit update destroy ]

  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.create(student_params)
    redirect_to student_path(@student)
  end

  def show; end  

  def edit; end  

  def update
    @student.update(student_params)
    redirect_to student_path(@student), notice: "Student updated successfully."
  end

  def destroy
  
  end 

  def set_student
    @student = Student.find(params[:id])
  end
  
  def student_params
    params.require(:student).permit(:first_name, :middle_name, :last_name, :email, :phone_no, :address)
  end
end
