# frozen_string_literal: true

class CheckBoxChoice < ApplicationRecord
  belongs_to :check_box

  validates :choices, presence: true, if: -> { check_box.survey_question.format == 'check_box' }
end
