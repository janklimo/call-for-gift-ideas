import Elm from './Main'

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('app');
  Elm.Main.embed(node)
})
