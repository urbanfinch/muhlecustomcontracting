var muhlecustomcontracting = {
  background_image: 0,
  
  run: function() {
    $('div.shadowbox').shadowbox();
    
    muhlecustomcontracting.initBackgroundImages();
    muhlecustomcontracting.addPlaceholders();
  },
  
  initBackgroundImages: function() {
    muhlecustomcontracting.background_image = Math.floor(Math.random() * $('div.background img').length);
    
    $('div.background img').hide();
    $('div.background img:eq(' + muhlecustomcontracting.background_image + ')').fadeIn(1000);
    
    var backgroundInterval = window.setInterval(function() {
      console.log(muhlecustomcontracting.background_image);
      $('div.background img:eq(' + muhlecustomcontracting.background_image + ')').fadeOut(1000, function() {
        if (muhlecustomcontracting.background_image >= ($('div.background img').length - 1)) {
          muhlecustomcontracting.background_image = 0;
        } else {
          muhlecustomcontracting.background_image += 1;
        }
        $('div.background img:eq(' + muhlecustomcontracting.background_image + ')').fadeIn(1000);
      });
    }, 8000);
  },
  
  addPlaceholders: function() {
    if ('placeholder' in document.createElement('input')) {
      return;
    }
    
    $.merge($('input[placeholder]'), $('textarea[placeholder]')).each(function (){
      var placeholderName = $(this).attr('id');
      var placeholderText = $(this).attr('placeholder');
      var placeholder = $('<label for='+ $(this).attr('id') +'>'+ placeholderText + '</label>');
      placeholder.attr('style', 'position: absolute; cursor: text; left: 12px; top: 12px; font-size: 10px; color: #AAAAAA;');
      
      $(this).before(placeholder);
      
      $(placeholder).click(function(){
        $('label[for=' + placeholderName + ']').hide();
        document.getElementById(placeholderName).focus();
      })
      $(this).focus(function(){
        $('label[for=' + placeholderName + ']').hide();
      })
    
      $(this).blur(function(){
        $('label[for=' + placeholderName + ']').show();
      })
    });
    
  }
}