// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.countdown
//= require twitter/bootstrap
//= require_tree .

$(document).ready(function() {
  $('a.link-not-implemented').on('click', function() {
    event.preventDefault();
    alert('준비중입니다');
  });

  $('.navbar.navbar-fixed-top .logo').hover(function(){
    $('.navbar.navbar-fixed-top .logo').stop().animate({"top":"0"},600);
    },function(){
    $('.navbar.navbar-fixed-top .logo').stop().animate({"top":"-135"},600);
  });

  var $container = $('.masonry_container');
  $container.imagesLoaded(function(){
    $container.masonry({
      itemSelector : '.masonry_item:visible'
    });
  });

});

