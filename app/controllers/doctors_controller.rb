class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all
  end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    @doctor.user = current_user
    @doctor.save

    if @doctor.save
      redirect_to doctors_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @doctor = Doctor.find(params[:id])
  end

  def update
    @doctor = Doctor.find(params[:id])
    if @doctor.update(doctor_params)
      redirect_to doctors_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.destroy
    redirect_to doctors_path, status: :see_other
  end


  private

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :specialty, :email)
  end

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end
end
