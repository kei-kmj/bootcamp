import dayjs from 'dayjs'

document.addEventListener('DOMContentLoaded', () => {
  const currentDateTimeButton = document.getElementById(
    'js-current-date-time-input-button'
  )
  if (!currentDateTimeButton) return
  const dateTimeField = document.getElementById('date_time_input_field')
  function reflectDateTime() {
    const currentDateTime = dayjs().format('YYYY-MM-DD HH:mm:ss')
    dateTimeField.value = currentDateTime
  }
  currentDateTimeButton.addEventListener('click', reflectDateTime)
})
