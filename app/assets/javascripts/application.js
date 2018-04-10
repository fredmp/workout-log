// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require popper
//= require cocoon
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function () {
  $('td').click(function (e) {
    var target = $(e.target);
    if ($('tr.mobile-view:visible').length > 0) {
      Turbolinks.visit($(e.target).siblings('td.main').find('a').attr('href'));
    }
  });
  $('a.add_fields')
    .data('association-insertion-method', 'after')
    .data('association-insertion-node', 'this');
  $('.links')
    .on('cocoon:after-insert', function (e, added) {
      var target = added.parents('form').attr('id').includes('workout') ? '.workout' : '.routine';

      var repsOld = $($(target + '_exercise_exercise_sets_reps')[1]);
      var weightOld = $($(target + '_exercise_exercise_sets_weight')[1]);
      var durationOld = $($(target + '_exercise_exercise_sets_duration')[1]);

      var repsNew = added.find(target + '_exercise_exercise_sets_reps').first().find('input');
      var weightNew = added.find(target + '_exercise_exercise_sets_weight').first().find('input');
      var durationNew = added.find(target + '_exercise_exercise_sets_duration').first().find('input');

      if (repsOld.length > 0) repsNew.val(repsOld.first().find('input').val());
      if (weightOld.length > 0) weightNew.val(weightOld.first().find('input').val());
      if (durationOld.length > 0) durationNew.val(durationOld.first().find('input').val());

      repsNew.focus();
      repsNew.select();
    });
    $('.notify').on('click', function () {
      $(this).parent().hide();
    });
    $('.notify.notice').parent().delay(5000).fadeOut();
    $('.exercise-index-main-actions > select').on('change', function () {
      var categoryParam = $(this).val() ? '?exercise_category_id=' + $(this).val() : '';
      Turbolinks.visit('/exercises' + categoryParam);
    });
});
