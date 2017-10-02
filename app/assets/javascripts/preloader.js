// using "preload" array from global namespace
var images = [];
if (typeof preload !== 'undefined') {
  for (var i = 0; i < preload.length; i++) {
    images[i] = new Image();
    images[i].src = preload[i];
  }
}
