// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require lib
//= require helpers
//= require_self
//= require_tree ./components
// require_tree .

const wow = new WOW({
  offset: 150
});
wow.init();

$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})

const csrfToken = $("meta[name=csrf-token]").attr("content")
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken

$(document).ready(() => {
  // let images = document.querySelectorAll(".lazy")
  // lazy = lazyload(images)
  lazyloadImages()
})
