schedule_cell = $('.schedule-cell')

if schedule_cell
  schedule_cell.on 'mouseenter',(handler) ->
    $(handler.target).find('.action-panel').show();
  schedule_cell.on 'mouseleave', ->
    $('.action-panel').hide();
