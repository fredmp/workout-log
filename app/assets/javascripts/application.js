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
    .on('cocoon:before-insert', function (e, added) {
      configureNewExerciseSetFields(
        $("select[id$='_exercise_exercise_id'] option:selected").data().fields + '',
        added.find("div[class$='exercise_exercise_sets_reps']").first(),
        added.find("div[class$='exercise_exercise_sets_weight']").first(),
        added.find("div[class$='exercise_exercise_sets_duration']").first(),
        added.find("div[class$='exercise_exercise_sets_distance']").first()
      );
    })
    .on('cocoon:after-insert', function (e, added) {
      var target = added.parents('form').attr('id').includes('workout') ? '.workout' : '.routine';

      var repsOld = $($(target + '_exercise_exercise_sets_reps')[1]);
      var weightOld = $($(target + '_exercise_exercise_sets_weight')[1]);
      var durationOld = $($(target + '_exercise_exercise_sets_duration')[1]);
      var distanceOld = $($(target + '_exercise_exercise_sets_distance')[1]);

      var repsNew = added.find(target + '_exercise_exercise_sets_reps').first().find('input');
      var weightNew = added.find(target + '_exercise_exercise_sets_weight').first().find('input');
      var durationNew = added.find(target + '_exercise_exercise_sets_duration').first().find('input');
      var distanceNew = added.find(target + '_exercise_exercise_sets_distance').first().find('input');

      if (repsOld.length > 0) repsNew.val(repsOld.first().find('input').val());
      if (weightOld.length > 0) weightNew.val(weightOld.first().find('input').val());
      if (durationOld.length > 0) durationNew.val(durationOld.first().find('input').val());
      if (distanceOld.length > 0) distanceNew.val(distanceOld.first().find('input').val());

      repsNew.focus();
      repsNew.select();
      $('.nested-fields.form-inline').removeClass('highlight-add-set');
      added.addClass('highlight-add-set');
      added.find('div > input').on('focus', function () {
        highlightSet(this);
      });
    });
    $('.notify').on('click', function () {
      $(this).parent().hide();
    });
    $('.notify.notice').parent().delay(5000).fadeOut();
    $('.exercise-index-main-actions > select,select[id="body_part_id"][class="exercises-index"]').on('change', function () {
      var isCategory = $(this).attr('id') == 'exercise_category_id';
      var categoryDropdown = $('.exercise-index-main-actions > select');
      var bodyPartDropdown = $('select[id="body_part_id"][class="exercises-index"]');
      Turbolinks.visit('/exercises?exercise_category_id=' + categoryDropdown.val() + '&body_part_id=' + (isCategory ? '' : bodyPartDropdown.val()));
    });
    $('select.categories-add-set,select.body-parts-add-set').on('change', function () {
      filterAddExerciseSet($('select.categories-add-set').val(), $('select.body-parts-add-set').val(), $(this));
    });
    $("input[id*='_exercise_exercise_sets_attributes_'").on('focus', function() {
      highlightSet(this);
    });
    $('#routine_exercise_exercise_id,#workout_exercise_exercise_id').on('change', function () {
      updateExerciseSetFieldsVisibility();
    });
    $('.weight-measure-unit > select').on('change', function () {
      changeSettings('weight-unit', { unit: $(this).val() });
    });
    $('.length-measure-unit > select').on('change', function () {
      changeSettings('length-unit', { unit: $(this).val() });
    });
    if ($('#routine_exercise_exercise_id,#workout_exercise_exercise_id').length > 0) {
      updateExerciseSetFieldsVisibility();
    }
});

function filterAddExerciseSet(categoryId, bodyPartId, target) {
  var exerciseDropdown = $("select[id$='_exercise_exercise_id'");
  exerciseDropdown.children("option").show();
  if (categoryId != '') {
    exerciseDropdown.children("option[data-category!='" + categoryId + "']").hide();
  }
  if (bodyPartId != '') {
    exerciseDropdown.children("option[data-body-parts!='" + bodyPartId + "']").hide();
  }
  if (target.attr('id') == 'exercise_category_id') {
    $('select.body-parts-add-set').val('').change();
  }
}

function configureNewExerciseSetFields(availableFields, repsDiv, weightDiv, durationDiv, distanceDiv) {
  repsDiv.css('display', availableFields.includes('1') ? 'flex' : 'none');
  weightDiv.css('display', availableFields.includes('2') ? 'flex' : 'none');
  durationDiv.css('display', availableFields.includes('3') ? 'flex' : 'none');
  distanceDiv.css('display', availableFields.includes('3') ? 'flex' : 'none');
}

function updateExerciseSetFieldsVisibility() {
  var exerciseType = $('#routine_exercise_exercise_id').length > 0 ? 'routine' : 'workout';
  var fields = $('#' + exerciseType + '_exercise_exercise_id option:selected').data().fields + '';
  $("div[class$='exercise_exercise_sets_reps']").css('display', fields.includes('1') ? 'flex' : 'none');
  $("div[class$='exercise_exercise_sets_weight']").css('display', fields.includes('2') ? 'flex' : 'none');
  $("div[class$='exercise_exercise_sets_duration']").css('display', fields.includes('3') ? 'flex' : 'none');
  $("div[class$='exercise_exercise_sets_distance']").css('display', fields.includes('3') ? 'flex' : 'none');

  fields.includes('2') ? $('div.weight-unit').show() : $('div.weight-unit').hide();
  fields.includes('4') ? $('div.length-unit').show() : $('div.length-unit').hide();

  updateActionButtonsVisibility();
}

function highlightSet(target) {
  $('.nested-fields.form-inline').removeClass('highlight-add-set');
  $(target).parent().parent().addClass('highlight-add-set');
}

function updateActionButtonsVisibility() {
  if ($("select[id$=_exercise_exercise_id]").val() === '') {
    $('a.add_fields').hide();
    $('div.nested-fields').hide();
    $("input[type='submit'").hide();
  } else {
    $('a.add_fields').show();
    $('div.nested-fields').show()
    $("input[type='submit'").show();
  }
}

function changeSettings(attribute, data) {
  var params = encodeURIComponent($('meta[name=csrf-token]').attr('content'));
  $.post('/settings/' + attribute + '?authenticity_token=' + params, data)
    .done(function (data) {
      showSettingsFeedbackMessage(true);
      $('.notify.notice').parent().delay(5000).fadeOut();
    })
    .fail(function (jqXHR, textStatus) {
      showSettingsFeedbackMessage(false);
    });
}

function showSettingsFeedbackMessage(success) {
  var settingsFeedback = $('.settings-feedback');
  settingsFeedback.find('h1').first().text(success ? 'Success' : 'Error');
  settingsFeedback.find('span').first().addClass('alerticon');
  settingsFeedback.find('span > img').first().attr('alt', success ? 'Notice' : 'Alert');
  settingsFeedback.find('span > img').first().attr('src', success ? $('.settings-notice').attr('src') : $('.settings-notice').attr('src'));
  settingsFeedback.find('span > img').first().attr('data-svg-fallback', success ? $('.settings-notice').attr('src') : $('.settings-notice').attr('src'));
  settingsFeedback.find('p').first().text(success ? 'Updated successfully' : 'There was an error during the update');
  settingsFeedback.appendTo('.row.feedback-message');
  settingsFeedback.removeClass('settings-feedback');
  settingsFeedback.addClass(success ? 'notify notice' : 'notify alert');
  $('.row.feedback-message').show();
}
