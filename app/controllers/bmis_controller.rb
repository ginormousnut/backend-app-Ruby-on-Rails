require "net/http"
require "uri"
require "json"

class BmisController < ApplicationController
  before_action :set_patient

  # GET /patients/:patient_id/bmi
  def show
    # Generating URL request to an external API https://www.freepublicapis.com/bmi-calculator-api
    # Params: [weight, height]
    uri = URI("https://www.freepublicapis.com/bmi-calculator-api")
    uri.query = URI.encode_www_form({
      weight: @patient.weight,
      height: @patient.height
    })

    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)
      render json: {
        patient_id: @patient.id,
        bmi: data["bmi"],
        category: data["category"]
      }
    else
      render json: { error: "Cannot fetch BMI from external API" }, status: :bad_request
    end
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def set_patient
    @patient = Patient.find(params[:patient_id])
  end
end
