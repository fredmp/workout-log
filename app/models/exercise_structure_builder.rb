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
      { name: 'Walking' },
      { name: 'Running' },
      { name: 'Swimming' },
      { name: 'Aquarobics' },
      { name: 'Cycling' },
      { name: 'Rowing' },
      { name: 'Boxing' }
    ],
    balance: [
      { name: 'Sumo squat with outer thigh pulse' },
      { name: 'Standing crunch with under-the-leg clap' },
      { name: 'Curtsy lunge with oblique crunch' },
      { name: 'Plank with flying plane arms' },
      { name: 'Rolling forearm side plank' },
      { name: 'Arm sequence with lifted heels' },
      { name: 'T-Stand with hinge and side bend' }
    ],
    flexibility: [
      { name: 'Standing hamstring stretch' },
      { name: 'Piriformis stretch' },
      { name: 'Lunge with spinal twist' },
      { name: 'Triceps stretch' },
      { name: 'Figure four stretch' },
      { name: 'Stretch 90/90' },
      { name: 'Frog stretch' },
      { name: 'Butterfly stretch' },
      { name: 'Seated shoulder squeeze' },
      { name: 'Side bend stretch' },
      { name: 'Lunging hip flexor stretch' },
      { name: 'Lying pectoral stretch' },
      { name: 'Knee to chest stretch' },
      { name: 'Seated neck release' },
      { name: 'Lying quad stretch' },
      { name: 'Sphinx pose' },
      { name: 'Extended puppy pose' },
      { name: 'Pretzel stretch' },
      { name: 'Reclining bound angle pose' },
      { name: 'Standing quad stretch' },
      { name: 'Knees to chest' }
    ],
    strength: [
      # Chest
      { name: 'Bench press', body_parts: [:chest] },
      { name: 'Bench press 45', body_parts: [:chest] },
      { name: 'Bench press 9O', body_parts: [:chest] },
      { name: 'Bench press decline', body_parts: [:chest] },
      { name: 'Push-up', body_parts: [:chest] },
      { name: 'Neck press', body_parts: [:chest] },
      { name: 'Vertical dips', body_parts: [:chest] },
      { name: 'Horizontal dips', body_parts: [:chest] },
      { name: 'Dumbbell bench press', body_parts: [:chest] },
      { name: 'Smith machine bench press', body_parts: [:chest] },
      { name: 'Pec deck chest fly', body_parts: [:chest] },
      { name: 'Dumbbell chest fly', body_parts: [:chest] },
      { name: 'Dumbbell chest fly incline', body_parts: [:chest] },
      { name: 'Dumbbell chest fly decline', body_parts: [:chest] },
      { name: 'Cable crossover', body_parts: [:chest] },
      # Back
      { name: 'Pulldown bar cable machine', body_parts: [:back] },
      { name: 'Pulldown machine', body_parts: [:back] },
      { name: 'Pullup bar cable machine', body_parts: [:back] },
      { name: 'Pullup machine', body_parts: [:back] },
      { name: 'Close grip', body_parts: [:back] },
      { name: 'Reverse grip', body_parts: [:back] },
      { name: 'Bent-over row dumbbell', body_parts: [:back] },
      { name: 'Bent-over row barbell', body_parts: [:back] },
      { name: 'Bent-over row smith machine', body_parts: [:back] },
      { name: 'Bent-over row t-bar machine', body_parts: [:back] },
      { name: 'Cable row - seated', body_parts: [:back] },
      { name: 'Back extension', body_parts: [:back] },
      { name: 'Back extension machine', body_parts: [:back] },
      # Shoulders
      { name: 'Upright row dumbbell', body_parts: [:shoulders] },
      { name: 'Upright row barbell', body_parts: [:shoulders] },
      { name: 'Upright row smith machine', body_parts: [:shoulders] },
      { name: 'Upright row cable machine', body_parts: [:shoulders] },
      { name: 'Shoulder press dumbbell - seated', body_parts: [:shoulders] },
      { name: 'Shoulder press kettlebell - seated', body_parts: [:shoulders] },
      { name: 'Shoulder press barbell - seated', body_parts: [:shoulders] },
      { name: 'Shoulder press smith machine - seated', body_parts: [:shoulders] },
      { name: 'Shoulder press dumbbell - standing', body_parts: [:shoulders] },
      { name: 'Shoulder press kettlebell - standing', body_parts: [:shoulders] },
      { name: 'Shoulder press barbell - standing', body_parts: [:shoulders] },
      { name: 'Shoulder press smith machine - standing', body_parts: [:shoulders] },
      { name: 'Lateral raise dumbbell', body_parts: [:shoulders] },
      { name: 'Lateral raise cable machine', body_parts: [:shoulders] },
      { name: 'Front raise dumbell', body_parts: [:shoulders] },
      # Triceps
      { name: 'Triceps pushdown cable machine h-bar', body_parts: [:triceps] },
      { name: 'Triceps pushdown cable machine v-bar', body_parts: [:triceps] },
      { name: 'Triceps pushdown cable machine rope', body_parts: [:triceps] },
      { name: 'Triceps extension dumbbell - seated', body_parts: [:triceps] },
      { name: 'Triceps extension barbell - seated', body_parts: [:triceps] },
      { name: 'Triceps extension dumbbell - lying', body_parts: [:triceps] },
      { name: 'Triceps extension barbell - lying', body_parts: [:triceps] },
      # Biceps:
      { name: 'Barbell curl', body_parts: [:biceps] },
      { name: 'Dumbbell curl', body_parts: [:biceps] },
      { name: 'Hammer curl', body_parts: [:biceps] },
      { name: 'Rotating dumbbell curl', body_parts: [:biceps] },
      { name: 'Barbell curl cable machine', body_parts: [:biceps] },
      { name: 'Barbell curl preacher bench', body_parts: [:biceps] },
      { name: 'Dumbbell curl preacher bench', body_parts: [:biceps] },
      { name: 'Hammer curl preacher bench', body_parts: [:biceps] },
      # Abdomen:
      { name: 'Crunch', body_parts: [:abdomen] },
      { name: 'Crunch - dumbbell', body_parts: [:abdomen] },
      { name: 'Crunch - machine', body_parts: [:abdomen] },
      { name: 'Crunch - reverse', body_parts: [:abdomen] },
      { name: 'Crunch - twisting', body_parts: [:abdomen] },
      { name: 'Crunch - cable', body_parts: [:abdomen] },
      { name: 'Crunch - sit-up', body_parts: [:abdomen] },
      { name: 'Crunch - vertical', body_parts: [:abdomen] },
      { name: 'Leg raise - front', body_parts: [:abdomen] },
      { name: 'Leg raise - side', body_parts: [:abdomen] },
      { name: 'Leg raise - knee to chest', body_parts: [:abdomen] },
      # Legs:
      { name: 'Barbell full squat', body_parts: [:legs] },
      { name: 'Barbell squat front', body_parts: [:legs] },
      { name: 'Hack squat', body_parts: [:legs] },
      { name: 'Leg press', body_parts: [:legs] },
      { name: 'Leg extension', body_parts: [:legs] },
      { name: 'Rear lunge barbell', body_parts: [:legs] },
      { name: 'Rear lunge dumbbell', body_parts: [:legs] },
      { name: 'Leg curl - seated', body_parts: [:legs] },
      { name: 'Leg curl - lying', body_parts: [:legs] },
      { name: 'Calf raise barbell - standing', body_parts: [:legs] },
      { name: 'Calf raise machine - seated', body_parts: [:legs] },
      { name: 'Calf press - leg press machine', body_parts: [:legs] },
      { name: 'Deadlift barbell', body_parts: [:legs] },
      { name: 'Step up dumbbell', body_parts: [:legs] },
      { name: 'Thigh abductor', body_parts: [:legs] }
    ]
  }
end
