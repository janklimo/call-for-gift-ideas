import Elm from '../Form/Main'

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('new-call')
  if (node !== null) {
    Elm.Form.Main.embed(node)
  }
})

const preload = [
  "https://s3-us-west-2.amazonaws.com/callforgiftideas/aw_yiss.png",
  "https://s3-us-west-2.amazonaws.com/callforgiftideas/ripple.gif"
];

let images = [];
for (let i = 0; i < preload.length; i++) {
    images[i] = new Image();
    images[i].src = preload[i];
}
