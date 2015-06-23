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

function sketch(processing) {
  // processing.draw = () => {
  //   console.log('draw');
  // };
  console.log(processing);
}
