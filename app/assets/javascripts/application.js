// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui/datepicker
//= require jquery-fileupload/basic
//= require foundation
// require_tree .
//= require jquery-smooth-scroll
//= require spin
//= require foundation-datetimepicker
//= require foundation-datepicker
//= require listings
//= require listings/build
//= require welcome
//= require galleria/galleria-1.4.2.min
//= require galleria/themes/classic/galleria.classic
//= require Chart
//= require turbolinks

$(document).ready(function() {

    $(document).foundation();

    $("input.date_picker").fdatepicker({
        format: "yyyy-mm-dd"
    });

    $('input.date_time_picker').fdatetimepicker({
        //format: 'yyyy-mm-dd hh:ii'
        format: 'dd/mm/yyyy hh:ii'
    });

  // Hide flash messages after 3 seconds
  setTimeout(function() {
    $("div[id^='flash_'").fadeOut('slow');
  }, 5000);

  var titlerowheight = $( '.titlerowselector' ).height();
  var titleborderspacing = titlerowheight / 2 - 1;
  $('.pagetitlebox').css('height',titleborderspacing);


// Retrieve current Pathname
    var path = $(location).attr('pathname');
// Removes everything before and including the first /
    var buildpage = path.split('/')[3]
    var page = path.split('/')[1]
    if (buildpage == 'build') {
        $("#" + buildpage).addClass("active");
    }
    else{
        $("#" + page).addClass("active");
    }

    // sets bottom bar colours in a bootleg way because no js/css pipeline :(
    if (window.location.pathname == "/"|| window.location.pathname == "/about"|| window.location.pathname == "/legal"|| window.location.pathname == "/brokers"|| window.location.pathname == "/contact"|| window.location.pathname == "/investors"){
        $('#footer').css('background-color','#262626')
        $('#footer .text-center ul li a').css('color','white')
    }
    var infobodyheight = $(window).height()-(75+175);
    $('.infobody').css('min-height',infobodyheight);

});

$(document).on('page:before-change', function() {
    console.log('clearing address');
    $("#last_listing_shortcut").empty();
});

function addlistinginnavbar(string) {
    console.log('Setting address');
    $("#last_listing_shortcut").html("<i></i>" + string);
    $("#last_listing_shortcut i").addClass("fa fa-caret-right");
    $("#last_listing_shortcut i").css("margin-right",10);
};

