import Elm from '../Form/Main'

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('new-call')
  if (node !== null) {
    Elm.Form.Main.embed(node)
  }
})
