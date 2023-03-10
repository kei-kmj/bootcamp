document.addEventListener('DOMContentLoaded', () => {
  const radioButtonChoices = document.getElementsByName(
    'survey_question[format]'
  )
  const radioButtonElements = document.querySelectorAll('.radio_button')
  const checkBoxElements = document.querySelectorAll('.check_box')
  const linearScaleElements = document.querySelectorAll('.linear_scale')
  const radioButtonTitleOfReasonForChoice = document.getElementById(
    'survey_question_radio_button_attributes_title_of_reason'
  )
  const checkBoxTitleOfReasonForChoice = document.getElementById(
    'survey_question_check_box_attributes_title_of_reason'
  )
  const linearScaleTitleOfReasonForChoice = document.getElementById(
    'survey_question_linear_scale_attributes_title_of_reason'
  )
  const radioButtonDescriptionOfReasonForChoice = document.getElementById(
    'survey_question_radio_button_attributes_description_of_reason'
  )
  const checkBoxDescriptionOfReasonForChoice = document.getElementById(
    'survey_question_check_box_attributes_description_of_reason'
  )
  const linearScaleDescriptionOfReasonForChoice = document.getElementById(
    'survey_question_linear_scale_attributes_description_of_reason'
  )
  const startOfScale = document.getElementById(
    'survey_question_linear_scale_attributes_first'
  )
  const endOfScale = document.getElementById(
    'survey_question_linear_scale_attributes_last'
  )
  const reasonForChoiceRequired = document.getElementById(
    'survey_question_linear_scale_attributes_reason_for_choice_required'
  )
  const switchIsHidden = (radioButtonChoice) => {
    if (
      radioButtonChoice.value === 'text_field' ||
      radioButtonChoice.value === 'text_area'
    ) {
      radioButtonElements.forEach((radioButtonElement) => {
        radioButtonElement.classList.add('is-hidden')
      })
      checkBoxElements.forEach((checkBoxElement) => {
        checkBoxElement.classList.add('is-hidden')
      })
      linearScaleElements.forEach((linearScaleElement) => {
        linearScaleElement.classList.add('is-hidden')
      })
    } else if (radioButtonChoice.value === 'radio_button') {
      radioButtonElements.forEach((radioButtonElement) => {
        radioButtonElement.classList.remove('is-hidden')
      })
      checkBoxElements.forEach((checkBoxElement) => {
        checkBoxElement.classList.add('is-hidden')
      })
      linearScaleElements.forEach((linearScaleElement) => {
        linearScaleElement.classList.add('is-hidden')
      })
    } else if (radioButtonChoice.value === 'check_box') {
      radioButtonElements.forEach((radioButtonElement) => {
        radioButtonElement.classList.add('is-hidden')
      })
      checkBoxElements.forEach((checkBoxElement) => {
        checkBoxElement.classList.remove('is-hidden')
      })
      linearScaleElements.forEach((linearScaleElement) => {
        linearScaleElement.classList.add('is-hidden')
      })
    } else if (radioButtonChoice.value === 'linear_scale') {
      radioButtonElements.forEach((radioButtonElement) => {
        radioButtonElement.classList.add('is-hidden')
      })
      checkBoxElements.forEach((checkBoxElement) => {
        checkBoxElement.classList.add('is-hidden')
      })
      linearScaleElements.forEach((linearScaleElement) => {
        linearScaleElement.classList.remove('is-hidden')
      })
    }
  }

  radioButtonChoices.forEach((radioButtonChoice) => {
    radioButtonChoice.checked && switchIsHidden(radioButtonChoice)
    radioButtonChoice.addEventListener('change', () => {
      const removeFieldsElements = document.querySelectorAll('.remove_fields')
      removeFieldsElements.forEach((removeFieldsElement) => {
        removeFieldsElement.click()
      })
      radioButtonTitleOfReasonForChoice.value = null
      radioButtonDescriptionOfReasonForChoice.value = null
      checkBoxTitleOfReasonForChoice.value = null
      checkBoxDescriptionOfReasonForChoice.value = null
      linearScaleTitleOfReasonForChoice.value = null
      linearScaleDescriptionOfReasonForChoice.value = null
      startOfScale.value = null
      endOfScale.value = null
      reasonForChoiceRequired.checked = false
      switchIsHidden(radioButtonChoice)
    })
  })
})
