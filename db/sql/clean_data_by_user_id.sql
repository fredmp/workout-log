delete from workout_exercises where workout_id = (select id from workouts where user_id = (select id from users where email = 'a@a.com.br'));
delete from workouts where user_id = (select id from users where email = 'a@a.com.br');
delete from routine_exercises where routine_id = (select id from routines where user_id = (select id from users where email = 'a@a.com.br'));
delete from routines where user_id = (select id from users where email = 'a@a.com.br');
delete from body_parts_exercises where body_part_id in (select id from body_parts where user_id = (select id from users where email = 'a@a.com.br'));
delete from body_parts where user_id = (select id from users where email = 'a@a.com.br');
delete from exercises where exercise_category_id in (select id from exercise_categories where user_id = (select id from users where email = 'a@a.com.br'));
delete from exercise_categories where user_id = (select id from users where email = 'a@a.com.br');