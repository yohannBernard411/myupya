const disabled = () => {
  const inputs = document.querySelectorAll('.edit_question span input')
  const button = document.querySelector('#button-question-form')
  inputs.forEach(input => {
    input.addEventListener('click', e => {
      button.disabled = false
    })
})
};

disabled()

export { disabled };
