$.fn.done_typing = function(callback, delay=200) {
  // init
  var timer;

  // on keyup, start the countdown
  $(this).keyup(function(){
    clearTimeout(timer);
    if (!$(this).val());{
      timer = setTimeout(callback, delay);
    }
  });
}


