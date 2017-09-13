import Elm from '../Wizard/Main'

document.addEventListener('DOMContentLoaded', () => {
  const flagsNode = document.getElementById('elm-flags')
  const data = JSON.parse(flagsNode.getAttribute('data'))

  const appNode = document.getElementById('wizard');
  Elm.Wizard.Main.embed(appNode, data)
})
