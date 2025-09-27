class Doctor < ApplicationRecord
  has_many :doctor_patients
  has_many :patients, through: :doctor_patients
end
