var wowhead_tooltips = {
  "colorlinks": true,
  "iconizelinks": true,
  "renamelinks": true
}

// HACK: This allows tooltips to be loaded when turbolinks does its
// voodoo magic. The timeout allows for the JS environment to be
// populated with the needed wowhead namespace.
//
$(window).bind('page:change', function(e) {
  setTimeout(function() {
    $WowheadPower.init();
  }, 100);
});
