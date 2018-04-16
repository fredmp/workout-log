class Stats
  def initialize(user, from = 6.months, to = Date.current, top = 6)
    @user = user
    @from = from
    @to = to
    @top = top
    @total_exercises = 0
    @total_categories = 0
    @total_body_parts = 0
    build_workouts
    build_initial_summary
    populate_summary
    calculate_percentages(:exercises)
    calculate_percentages(:categories)
    calculate_percentages(:body_parts)
  end

  def last_workout
    return @last_workout if @last_workout
    workout = @workouts.first || @user.workouts.order(date: :desc).first
    exercises = []
    categories = []
    body_parts = []
    workout.workout_exercises.each do |workout_exercise|
      exercises << workout_exercise.exercise
      categories << workout_exercise.exercise.exercise_category
      body_parts = body_parts + workout_exercise.exercise.body_parts
    end
    @last_workout = OpenStruct.new({
      id: workout.id,
      date: workout.date,
      exercises: exercises.uniq.map { |e| e.name }.take(5),
      categories: categories.uniq.map { |c| c.name }.take(5),
      body_parts: body_parts.uniq.map { |bp| bp.name }.take(10)
    })
  end

  def summary
    @summary
  end

  def top_exercises
    @top_exercises ||= @summary.exercises.values.sort do |a, b|
      a[:number] <=> b[:number]
    end.reverse.take(@top).map do |t|
      t[:name]
    end
  end

  private

  def build_workouts
    @workouts = @user.workouts.where('date > ?', @to - @from).order(date: :desc)
  end

  def build_initial_summary
    @summary = OpenStruct.new(
      number_of_workouts: @workouts.size,
      number_of_exercises: 0,
      sets: 0,
      reps: 0,
      exercises: {},
      categories: {},
      body_parts: {},
      intervals: {}
    )
  end

  def populate_summary
    dates = []
    @workouts.each do |workout|
      dates << workout.date
      workout.workout_exercises.each do |workout_exercise|
        add_workout_exercise(workout_exercise)
      end
    end
    add_intervals(dates)
  end

  def calculate_percentages(attribute)
    @summary.send(attribute).each_value do |entry|
      entry[:percentage] = (entry[:number] * 100.0 / instance_variable_get("@total_#{attribute.to_s}")).round(2)
    end
  end

  def add_workout_exercise(workout_exercise)
    @summary.number_of_exercises = @summary.number_of_exercises + 1
    add_exercise(workout_exercise.exercise)
    add_category(workout_exercise.exercise.exercise_category)
    add_body_parts(workout_exercise.exercise.body_parts)
    add_sets_and_reps(workout_exercise.sets)
  end

  def add_exercise(exercise)
    create_exercise_entry_if_needed(exercise)
    @total_exercises = @total_exercises + 1
    @summary.exercises[exercise.id][:number] = @summary.exercises[exercise.id][:number] + 1
  end

  def add_category(category)
    create_category_entry_if_needed(category)
    @total_categories = @total_categories + 1
    @summary.categories[category.id][:number] = @summary.categories[category.id][:number] + 1
  end

  def add_body_parts(body_parts)
    body_parts.each do |body_part|
      create_body_part_entry_if_needed(body_part)
      @total_body_parts = @total_body_parts + 1
      @summary.body_parts[body_part.id][:number] = @summary.body_parts[body_part.id][:number] + 1
    end
  end

  def create_exercise_entry_if_needed(exercise)
    return if @summary.exercises.key?(exercise.id)
    @summary.exercises[exercise.id] = { name: exercise.name, number: 0 }
  end

  def create_body_part_entry_if_needed(body_part)
    return if @summary.body_parts.key?(body_part.id)
    @summary.body_parts[body_part.id] = { name: body_part.name, number: 0 }
  end

  def create_category_entry_if_needed(category)
    return if @summary.categories.key?(category.id)
    @summary.categories[category.id] = { name: category.name, number: 0 }
  end

  def add_intervals(dates)
    intervals = build_intervals(dates)
    if intervals.any?
      @summary.intervals = {
        avg: intervals.sum / intervals.size,
        min: intervals.min,
        max: intervals.max
      }
    end
    @summary.intervals[:any] = true
  end

  def build_intervals(dates)
    intervals = []
    dates.reverse.each_cons(2) do |entry|
      intervals << (entry.last.to_date - entry.first.to_date).to_i
    end
    intervals
  end

  def add_sets_and_reps(sets)
    sets.each do |set|
      @summary.sets = @summary.sets + 1
      @summary.reps = @summary.reps + set.reps if set.reps
    end
  end
end
