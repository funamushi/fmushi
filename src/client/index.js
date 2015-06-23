'use strict';

import Rx from 'rx';
import * as processing from 'processing-js';

console.log(processing);

(function(callback) {
  if (document.readyState != 'loading'){
    callback();
  } else {
    document.addEventListener('DOMContentLoaded', callback);
  }
})(init);

function init() {
}

function update() {
}

