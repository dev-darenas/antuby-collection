import 'bootstrap';
import '../stylesheets/application'
import "@fortawesome/fontawesome-free/js/all";

import init from '../src/init'; 

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require('jquery')

init();
