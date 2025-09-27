class BmrsController < ApplicationController
    before_action :set_patient

  # GET /patients/:patient_id/bmrs
  def index
    bmrs = @patient.bmrs
    limit = params[:limit].presence || 10
    offset = params[:offset].presence || 0
    bmrs = bmrs.limit(limit).offset(offset)

    render json: bmrs
  end

  # POST /patients/:patient_id/bmrs
  def create
    formula = params[:formula] # "mifflin" или "harris"
    value = calculate_bmr(@patient, formula)

    bmr = @patient.bmrs.new(formula: formula, value: value)

    if bmr.save
      render json: bmr, status: :created
    else
      render json: bmr.errors, status: :unprocessable_entity
    end
  end

  private

  def set_patient
    @patient = Patient.find(params[:patient_id])
  end

  def calculate_bmr(patient, formula)
    height = patient.height.to_f
    weight = patient.weight.to_f
    age = ((Date.today - patient.birthday).to_i / 365.25).floor

    case formula.downcase
    when "mifflin"
      # Mifflin-St. Jeor Equation
      if patient.gender.downcase == "male"
        10 * weight + 6.25 * height - 5 * age + 5
      else
        10 * weight + 6.25 * height - 5 * age - 161
      end
    when "harris"
      # Harris-Benedict Equation
      if patient.gender.downcase == "male"
        66.5 + 13.75 * weight + 5.003 * height - 6.755 * age
      else
        655.1 + 9.563 * weight + 1.850 * height - 4.676 * age
      end
    else
      0
    end
  end
end
