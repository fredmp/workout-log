class ExerciseStructureBuilder
  
  def initialize(user)
    @user = user
  end

  def build
    begin
      load_existing_structure
      create_categories
      create_body_parts
      create_exercises
    rescue => exception
      false
    end
    true
  end

  private

  def create_exercises
    @user.reload
    categories = @user.exercise_categories
    body_parts = @user.body_parts

    INITIAL_EXERCISES_MAP.each do |category_key, exercises|
      category = categories.detect { |c| c.name == category_key.to_s.capitalize }
      exercises.each do |exercise_entry|
        unless @existing_exercises_names.include?(exercise_entry[:name])
          exercise = category.exercises.build(name: exercise_entry[:name])
          if exercise_entry[:body_parts]
            exercise.body_parts = body_parts.select { |bp| exercise_entry[:body_parts].include?(bp.name.downcase.to_sym) }
          end
          exercise.available_fields_definition = exercise_entry[:fields]
          exercise.save
        end
      end
    end
  end

  def create_categories
    INITIAL_EXERCISE_CATEGORIES.each do |name, value|
      @user.exercise_categories.create(name: name, description: value) unless @existing_exercise_category_names.include?(name)
    end
  end

  def create_body_parts
    INITIAL_BODY_PARTS.each do |name|
      @user.body_parts.create(name: name) unless @existing_body_part_names.include?(name)
    end
  end

  def load_existing_structure
    @existing_exercise_category_names = @user.exercise_categories.pluck(:name)
    @existing_body_part_names = @user.body_parts.pluck(:name)
    @existing_exercises_names = @user.exercises.pluck(:name)
  end

  INITIAL_BODY_PARTS = %w(Chest Back Shoulders Triceps Biceps Abdomen Legs)
  INITIAL_EXERCISE_CATEGORIES = {
    'Aerobic' => 'Aerobic, or endurance, are activities that increase your breathing and heart rate. They keep your heart, lungs, and circulatory system healthy and improve your overall fitness. Building your endurance makes it easier to carry out many of your everyday activities.',
    'Strength' => 'Strength exercises make your muscles stronger. They may help you stay independent and carry out everyday activities, such as climbing stairs and carrying groceries. These exercises also are called strength training or resistance training.',
    'Balance' => 'Balance exercises help prevent falls, a common problem in older adults. Many lower-body strength exercises also will improve your balance.',
    'Flexibility' => 'Flexibility exercises stretch your muscles and can help your body stay limber. Being flexible gives you more freedom of movement for other exercises as well as for your everyday activities.'
  }
  INITIAL_EXERCISES_MAP = {
    aerobic: [
      { name: 'Walking', fields: '3' },
      { name: 'Running', fields: '3' },
      { name: 'Swimming', fields: '3' },
      { name: 'Aquarobics', fields: '3' },
      { name: 'Cycling', fields: '3' },
      { name: 'Rowing', fields: '3' },
      { name: 'Boxing', fields: '3' }
    ],
    balance: [
      { name: 'Sumo squat with outer thigh pulse', fields: '1' },
      { name: 'Standing crunch with under-the-leg clap', fields: '1' },
      { name: 'Curtsy lunge with oblique crunch', fields: '1' },
      { name: 'Plank with flying plane arms', fields: '1' },
      { name: 'Rolling forearm side plank', fields: '1' },
      { name: 'Arm sequence with lifted heels', fields: '1' },
      { name: 'T-Stand with hinge and side bend', fields: '1' }
    ],
    flexibility: [
      { name: 'Standing hamstring stretch', fields: '1' },
      { name: 'Piriformis stretch', fields: '1' },
      { name: 'Lunge with spinal twist', fields: '1' },
      { name: 'Triceps stretch', fields: '1' },
      { name: 'Figure four stretch', fields: '1' },
      { name: 'Stretch 90/90', fields: '1' },
      { name: 'Frog stretch', fields: '1' },
      { name: 'Butterfly stretch', fields: '1' },
      { name: 'Seated shoulder squeeze', fields: '1' },
      { name: 'Side bend stretch', fields: '1' },
      { name: 'Lunging hip flexor stretch', fields: '1' },
      { name: 'Lying pectoral stretch', fields: '1' },
      { name: 'Knee to chest stretch', fields: '1' },
      { name: 'Seated neck release', fields: '1' },
      { name: 'Lying quad stretch', fields: '1' },
      { name: 'Sphinx pose', fields: '1' },
      { name: 'Extended puppy pose', fields: '1' },
      { name: 'Pretzel stretch', fields: '1' },
      { name: 'Reclining bound angle pose', fields: '1' },
      { name: 'Standing quad stretch', fields: '1' },
      { name: 'Knees to chest', fields: '1' }
    ],
    strength: [
      # Chest
      { name: 'Bench press', body_parts: [:chest], fields: '1-2' },
      { name: 'Bench press 45', body_parts: [:chest], fields: '1-2' },
      { name: 'Bench press 90', body_parts: [:chest], fields: '1-2' },
      { name: 'Bench press decline', body_parts: [:chest], fields: '1-2' },
      { name: 'Push-up', body_parts: [:chest], fields: '1-2' },
      { name: 'Neck press', body_parts: [:chest], fields: '1-2' },
      { name: 'Vertical dips', body_parts: [:chest], fields: '1-2' },
      { name: 'Horizontal dips', body_parts: [:chest], fields: '1-2' },
      { name: 'Dumbbell bench press', body_parts: [:chest], fields: '1-2' },
      { name: 'Smith machine bench press', body_parts: [:chest], fields: '1-2' },
      { name: 'Pec deck chest fly', body_parts: [:chest], fields: '1-2' },
      { name: 'Dumbbell chest fly', body_parts: [:chest], fields: '1-2' },
      { name: 'Dumbbell chest fly incline', body_parts: [:chest], fields: '1-2' },
      { name: 'Dumbbell chest fly decline', body_parts: [:chest], fields: '1-2' },
      { name: 'Cable crossover', body_parts: [:chest], fields: '1-2' },
      # Back
      { name: 'Pulldown bar cable machine', body_parts: [:back], fields: '1-2' },
      { name: 'Pulldown machine', body_parts: [:back], fields: '1-2' },
      { name: 'Pullup bar cable machine', body_parts: [:back], fields: '1-2' },
      { name: 'Pullup machine', body_parts: [:back], fields: '1-2' },
      { name: 'Close grip', body_parts: [:back], fields: '1-2' },
      { name: 'Reverse grip', body_parts: [:back], fields: '1-2' },
      { name: 'Bent-over row dumbbell', body_parts: [:back], fields: '1-2' },
      { name: 'Bent-over row barbell', body_parts: [:back], fields: '1-2' },
      { name: 'Bent-over row smith machine', body_parts: [:back], fields: '1-2' },
      { name: 'Bent-over row t-bar machine', body_parts: [:back], fields: '1-2' },
      { name: 'Cable row - seated', body_parts: [:back], fields: '1-2' },
      { name: 'Back extension', body_parts: [:back], fields: '1-2' },
      { name: 'Back extension machine', body_parts: [:back], fields: '1-2' },
      # Shoulders
      { name: 'Upright row dumbbell', body_parts: [:shoulders], fields: '1-2' },
      { name: 'Upright row barbell', body_parts: [:shoulders], fields: '1-2' },
      { name: 'Upright row smith machine', body_parts: [:shoulders], fields: '1-2' },
      { name: 'Upright row cable machine', body_parts: [:shoulders], fields: '1-2' },
      { name: 'Shoulder press dumbbell - seated', body_parts: [:shoulders], fields: '1-2' },
      { name: 'Shoulder press kettlebell - seated', body_parts: [:shoulders], fields: '1-2' },
      { name: 'Shoulder press barbell - seated', body_parts: [:shoulders], fields: '1-2' },
      { name: 'Shoulder press smith machine - seated', body_parts: [:shoulders], fields: '1-2' },
      { name: 'Shoulder press dumbbell - standing', body_parts: [:shoulders], fields: '1-2' },
      { name: 'Shoulder press kettlebell - standing', body_parts: [:shoulders], fields: '1-2' },
      { name: 'Shoulder press barbell - standing', body_parts: [:shoulders], fields: '1-2' },
      { name: 'Shoulder press smith machine - standing', body_parts: [:shoulders], fields: '1-2' },
      { name: 'Lateral raise dumbbell', body_parts: [:shoulders], fields: '1-2' },
      { name: 'Lateral raise cable machine', body_parts: [:shoulders], fields: '1-2' },
      { name: 'Front raise dumbell', body_parts: [:shoulders], fields: '1-2' },
      # Triceps
      { name: 'Triceps pushdown cable machine h-bar', body_parts: [:triceps], fields: '1-2' },
      { name: 'Triceps pushdown cable machine v-bar', body_parts: [:triceps], fields: '1-2' },
      { name: 'Triceps pushdown cable machine rope', body_parts: [:triceps], fields: '1-2' },
      { name: 'Triceps extension dumbbell - seated', body_parts: [:triceps], fields: '1-2' },
      { name: 'Triceps extension barbell - seated', body_parts: [:triceps], fields: '1-2' },
      { name: 'Triceps extension dumbbell - lying', body_parts: [:triceps], fields: '1-2' },
      { name: 'Triceps extension barbell - lying', body_parts: [:triceps], fields: '1-2' },
      # Biceps:
      { name: 'Barbell curl', body_parts: [:biceps], fields: '1-2' },
      { name: 'Dumbbell curl', body_parts: [:biceps], fields: '1-2' },
      { name: 'Hammer curl', body_parts: [:biceps], fields: '1-2' },
      { name: 'Rotating dumbbell curl', body_parts: [:biceps], fields: '1-2' },
      { name: 'Barbell curl cable machine', body_parts: [:biceps], fields: '1-2' },
      { name: 'Barbell curl preacher bench', body_parts: [:biceps], fields: '1-2' },
      { name: 'Dumbbell curl preacher bench', body_parts: [:biceps], fields: '1-2' },
      { name: 'Hammer curl preacher bench', body_parts: [:biceps], fields: '1-2' },
      # Abdomen:
      { name: 'Crunch', body_parts: [:abdomen], fields: '1' },
      { name: 'Crunch - dumbbell', body_parts: [:abdomen], fields: '1-2' },
      { name: 'Crunch - machine', body_parts: [:abdomen], fields: '1-2' },
      { name: 'Crunch - reverse', body_parts: [:abdomen], fields: '1-2' },
      { name: 'Crunch - twisting', body_parts: [:abdomen], fields: '1-2' },
      { name: 'Crunch - cable', body_parts: [:abdomen], fields: '1-2' },
      { name: 'Crunch - sit-up', body_parts: [:abdomen], fields: '1-2' },
      { name: 'Crunch - vertical', body_parts: [:abdomen], fields: '1' },
      { name: 'Leg raise - front', body_parts: [:abdomen], fields: '1' },
      { name: 'Leg raise - side', body_parts: [:abdomen], fields: '1' },
      { name: 'Leg raise - knee to chest', body_parts: [:abdomen], fields: '1' },
      # Legs:
      { name: 'Barbell full squat', body_parts: [:legs], fields: '1-2' },
      { name: 'Barbell squat front', body_parts: [:legs], fields: '1-2' },
      { name: 'Hack squat', body_parts: [:legs], fields: '1-2' },
      { name: 'Leg press', body_parts: [:legs], fields: '1-2' },
      { name: 'Leg extension', body_parts: [:legs], fields: '1-2' },
      { name: 'Rear lunge barbell', body_parts: [:legs], fields: '1-2' },
      { name: 'Rear lunge dumbbell', body_parts: [:legs], fields: '1-2' },
      { name: 'Leg curl - seated', body_parts: [:legs], fields: '1-2' },
      { name: 'Leg curl - lying', body_parts: [:legs], fields: '1-2' },
      { name: 'Calf raise barbell - standing', body_parts: [:legs], fields: '1-2' },
      { name: 'Calf raise machine - seated', body_parts: [:legs], fields: '1-2' },
      { name: 'Calf press - leg press machine', body_parts: [:legs], fields: '1-2' },
      { name: 'Deadlift barbell', body_parts: [:legs], fields: '1-2' },
      { name: 'Step up dumbbell', body_parts: [:legs], fields: '1-2' },
      { name: 'Thigh abductor', body_parts: [:legs], fields: '1-2' }
    ]
  }
end
