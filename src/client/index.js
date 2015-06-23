'use strict';

import Rx from 'rx';
import 'processing-js';

(function(callback) {
  if (document.readyState != 'loading'){
    callback();
  } else {
    document.addEventListener('DOMContentLoaded', callback);
  }
})(function() {
  let canvas = document.getElementById('stage');
  let processing = new Processing(canvas, sketch);
});

function sketch(p) {
  p.size(500, 500);

  let radius = 200;
  let center = { x: p.width * 0.5, y: p.height * 0.5 };
  // processing.draw = () => {
  //   console.log('draw');
  // };
  p.smooth();
  p.background(230, 230, 230);
  p.fill(255, 150);
  p.ellipse(250, 250, radius, radius);
  p.stroke(130, 0, 0);
  p.strokeWeight(4);
  p.line(center.x - 70, center.y - 70, center.x + 70, center.y + 70);
  p.line(center.x + 70, center.y - 70, center.x - 70, center.y + 70);
}
