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
//= require jquery
//= require rails-ujs
//= require bootstrap
//= require leaflet
//= require leaflet.markercluster
//= require gmaps-auto-complete
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require bootstrap-notify
//= require datetime_picker_input
//= require jquery.validate.localization/messages_en.js
//= require jquery.validate.localization/messages_fr.js
//= require_tree .

//toggle passenger image
function showImage() {
  $('#passenger_image').toggle();
  $('#photo').toggleClass('btn-default btn-primary');
}

// toggle contact and info modals
$(function () {
    $('#basicExampleModal').on('hidden.bs.modal', function () {
        $('#contact').toggleClass('btn-default btn-primary');
      });

    $('#contact').click(function () {
        $('#contact').toggleClass('btn-default btn-primary');
      });

  });
