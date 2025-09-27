class DoctorsController < ApplicationController
    before_action :set_doctor, only: [ :show, :update, :destroy ]

  # GET /doctors
  def index
    doctors = Doctor.all

    # pagination
    limit = params[:limit].presence || 10
    offset = params[:offset].presence || 0
    doctors = doctors.limit(limit).offset(offset)

    render json: doctors
  end

  # GET /doctors/:id
  def show
    render json: @doctor
  end

  # POST /doctors
  def create
    doctor = Doctor.new(doctor_params)

    if doctor.save
      render json: doctor, status: :created
    else
      render json: doctor.errors, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /doctors/:id
  def update
    if @doctor.update(doctor_params)
      render json: @doctor
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /doctors/:id
  def destroy
    @doctor.destroy
    head :no_content
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def doctor_params
    params.require(:doctor).permit(:first_name, :last_name, :middle_name)
  end
end
