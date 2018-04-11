delete from routine_exercises where routine_id in (select id from routines where user_id = 1);
delete from workout_exercises where workout_id in (select id from workouts where user_id = 1);
delete from routines where user_id = 1;
delete from workouts where user_id = 1;
delete from body_parts_exercises where body_part_id in (select id from body_parts where user_id = 1);
delete from body_parts where user_id = 1;
delete from exercises where exercise_category_id in (select id from exercise_categories where user_id = 1);
delete from exercise_categories where user_id = 1;