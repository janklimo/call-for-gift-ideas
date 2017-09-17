import Elm from '../Wizard/Main'

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('wizard')
  const data = JSON.parse(node.getAttribute('data'))
  Elm.Wizard.Main.embed(node, data)
})
