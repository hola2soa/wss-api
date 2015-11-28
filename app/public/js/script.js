 $(window).load(function(){
  $("#color_picker").ColorPickerSliders({
      flat: true,
      sliders: false,
      previewontriggerelement: true,
      invalidcolorsopacity: 0,
      onchange: function(container, color) {
        $("#color_picker_input").css("background-color", color.tiny.toRgbString());
      }
  });
});
