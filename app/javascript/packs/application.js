// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You"re encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it"ll be compiled.
//= require jquery
//= require jquery_ujs
//= require toastr
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require popper

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'bootstrap';
require('admin-lte');
require("bootstrap");
require("jquery");
require("jquery-validation")
require("select2")
require("cocoon");
// import "admin-lte/dist/css/AdminLTE.css";
import "font-awesome/css/font-awesome.css";
// require('../stylesheets/application');
import "@fortawesome/fontawesome-free/js/all";
import Swal from 'sweetalert2/dist/sweetalert2.js'
import 'sweetalert2/src/sweetalert2.scss'
import "chartkick/chart.js"
window.Swal = Swal;
require("./product")
require("./common");
require("./auth")
require("chartkick")
require("chart.js")

global.toastr = require("toastr")
// document.addEventListener("turbolinks:load", () => {
//   $('[data-toggle="tooltip"]').tooltip()
// });

Rails.start()
Turbolinks.start()
ActiveStorage.start()

