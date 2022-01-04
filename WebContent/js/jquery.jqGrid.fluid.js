/* auto-resize jqgrids for fluid layouts */
function jqgrid_fluid_resize(grid, gridParent) {
  grid.setGridWidth(gridParent.width());
}

function jqgrid_fluid_trigger(grid) {
  jQuery.resize.delay = 100;
  gridId = jQuery(grid).attr('id');
  gridParent = jQuery('#gbox_' + gridId).parent();
  gridParent.bind('resize', function() {
    jqgrid_fluid_resize(jQuery(grid), gridParent);
  });
};

