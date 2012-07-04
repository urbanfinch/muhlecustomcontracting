(function($){
  
  $.fn.extend({ 
    shadowbox: function(options) {
      var defaults = {
          shadowbox_class: 'shadowbox',
          prev_button_class: 'prev',
          next_button_class : 'next',
          close_button_class : 'close'
      }
      
      var options =  $.extend(defaults, options);
      
      var run = function(selected_image, shadowbox, options) {
        $('div.shadowbox img').attr('src', $('img', selected_image).attr('data-original'));
        $(shadowbox).show();
        $('div.shadowbox_overlay', shadowbox).show();
        $('div.shadowbox_window', shadowbox).fadeIn(1000);
        
        var images = $('a.shadowbox');
        var images_count = images.length;
        var position = 0;
        
        images.each(function(index) {
          if (this == selected_image) {
            position = index;
          }
        })
        
        $('a.' + options.prev_button_class).click(function(event) {
          position -= 1;
          if (position < 0) {
            position = 0;
          }
          $('div.shadowbox img').attr('src', $('img', images[position]).attr('data-original'));
          event.preventDefault();
        });
        $('a.' + options.next_button_class).click(function(event) {
          position += 1;
          if (position >= images_count) {
            position = images.length - 1;
          }
          $('div.shadowbox img').attr('src', $('img', images[position]).attr('data-original'));
          event.preventDefault();
        });
        $('a.' + options.close_button_class).click(function(event) {
          $(shadowbox).hide();
          $('div.shadowbox_overlay', shadowbox).hide();
          $('div.shadowbox_window', shadowbox).fadeOut(1000);
          event.preventDefault();
        });
      }
      
      return this.each(function() {
        var shadowbox = this;
        $('a.' + options.shadowbox_class).each(function() {
          $(this).click(function(event) {
            run(this, shadowbox, options);
            event.preventDefault();
          });
        });
      });
    }
  });
})(jQuery);