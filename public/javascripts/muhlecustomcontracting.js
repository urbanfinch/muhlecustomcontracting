var muhlecustomcontracting = {
  run: function() {
    muhlecustomcontracting.addPlaceholders();
  },
  
  addPlaceholders: function() {
    if ('placeholder' in document.createElement('input')) {
      return;
    }
    
    $.merge($('input[placeholder]'), $('textarea[placeholder]')).each(function (){
      var placeholderName = $(this).attr('id');
      var placeholderText = $(this).attr('placeholder');
      var placeholder = $('<label for='+ $(this).attr('id') +'>'+ placeholderText + '</label>');
      placeholder.attr('style', 'position: absolute; cursor: text; left: 8px; top: 8px; font-size: 10px; color: #AAAAAA;');
      
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