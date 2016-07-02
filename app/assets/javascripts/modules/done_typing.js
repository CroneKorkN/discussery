$.fn.done_typing = function(callback) {
  // init
  var timer;
  var delay = 500;

  // on keyup, start the countdown
  $(this).keyup(function(){
    clearTimeout(timer);
    if (!$(this).val());{
      timer = setTimeout(callback, delay);
    }
  });
}


