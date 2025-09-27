class PatientsController < ApplicationController
  before_action :set_patient, only: [ :show, :update, :destroy ]

  # GET /patients
  def index
    patients = Patient.all

    # фильтры
    if params[:full_name].present?
      patients = patients.where(
        "first_name ILIKE :q OR last_name ILIKE :q OR middle_name ILIKE :q",
        q: "%#{params[:full_name]}%"
      )
    end

    if params[:gender].present?
      patients = patients.where(gender: params[:gender])
    end

    if params[:start_age].present?
      patients = patients.where("birthday <= ?", Date.today - params[:start_age].to_i.years)
    end

    if params[:end_age].present?
      patients = patients.where("birthday >= ?", Date.today - params[:end_age].to_i.years)
    end

    # pagination
    limit = params[:limit].presence || 10
    offset = params[:offset].presence || 0
    patients = patients.limit(limit).offset(offset)

    render json: patients
  end

  # GET /patients/:id
  def show
    render json: @patient
  end

  # POST /patients
  def create
    patient = Patient.new(patient_params)

    if patient.save
      render json: patient, status: :created
    else
      render json: patient.errors, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /patients/:id
  def update
    if @patient.update(patient_params)
      render json: @patient
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  # DELETE /patients/:id
  def destroy
    @patient.destroy
    head :no_content
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(
      :first_name, :last_name, :middle_name,
      :birthday, :gender, :height, :weight,
      doctor_ids: [] # opportunity to list doctors
    )
  end
end
