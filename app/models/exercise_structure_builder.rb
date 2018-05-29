class ExerciseStructureBuilder
  
  def initialize(user)
    @user = user
    @locale = user.locale || I18n.default_locale
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
    exercise_map = @locale == 'pt' ? initial_exercise_map_pt : initial_exercise_map_en
    exercise_map.each do |category_key, exercises|
      category = categories.detect { |c| c.name == initial_exercise_categories[category_key][:name] }
      exercises.each do |exercise_entry|
        unless @existing_exercises_names.include?(exercise_entry[:name])
          exercise = category.exercises.build(name: exercise_entry[:name])
          if exercise_entry[:body_parts]
            exercise.body_parts = body_parts.select { |bp| exercise_entry[:body_parts].include?(initial_body_parts.key(bp.name)) }
          end
          exercise.available_fields_definition = exercise_entry[:fields]
          exercise.save
        end
      end
    end
  end

  def create_categories
    initial_exercise_categories.each_value do |entry|
      @user.exercise_categories.create(name: entry[:name], description: entry[:description]) unless @existing_exercise_category_names.include?(entry[:name])
    end
  end

  def create_body_parts
    initial_body_parts.each_value do |name|
      @user.body_parts.create(name: name) unless @existing_body_part_names.include?(name)
    end
  end

  def load_existing_structure
    @existing_exercise_category_names = @user.exercise_categories.pluck(:name)
    @existing_body_part_names = @user.body_parts.pluck(:name)
    @existing_exercises_names = @user.exercises.pluck(:name)
  end

  def initial_body_parts
    {
      chest: I18n.t(:chest, scope: [:builders, :body_parts], locale: @locale),
      back: I18n.t(:back, scope: [:builders, :body_parts], locale: @locale),
      shoulders: I18n.t(:shoulders, scope: [:builders, :body_parts], locale: @locale),
      triceps: I18n.t(:triceps, scope: [:builders, :body_parts], locale: @locale),
      biceps: I18n.t(:biceps, scope: [:builders, :body_parts], locale: @locale),
      abdomen: I18n.t(:abdomen, scope: [:builders, :body_parts], locale: @locale),
      legs: I18n.t(:legs, scope: [:builders, :body_parts], locale: @locale)
    }
  end

  def initial_exercise_categories
    {
      aerobic: {
        name: I18n.t(:aerobic, scope: [:builders, :category_names], locale: @locale),
        description: I18n.t(:aerobic, scope: [:builders, :category_descriptions], locale: @locale)
      },
      strength: {
        name: I18n.t(:strength, scope: [:builders, :category_names], locale: @locale),
        description: I18n.t(:strength, scope: [:builders, :category_descriptions], locale: @locale)
      },
      balance: {
        name: I18n.t(:balance, scope: [:builders, :category_names], locale: @locale),
        description: I18n.t(:balance, scope: [:builders, :category_descriptions], locale: @locale)
      },
      flexibility: {
        name: I18n.t(:flexibility, scope: [:builders, :category_names], locale: @locale),
        description: I18n.t(:flexibility, scope: [:builders, :category_descriptions], locale: @locale)
      }
    }
  end
  def initial_exercise_map_pt
    {
      aerobic: [
        { name: 'Caminhada', fields: '3-4' },
        { name: 'Corrida', fields: '3-4' },
        { name: 'Natação', fields: '3-4' },
        { name: 'Hidroginástica', fields: '3' },
        { name: 'Ciclismo', fields: '3-4' },
        { name: 'Remo', fields: '3-4' },
        { name: 'Boxe', fields: '3' }
      ],
      balance: [
        { name: 'Equilíbrio em um pé só', fields: '1' },
        { name: 'Balanço de perna', fields: '1' },
        { name: 'Movimento de relógio com os braços', fields: '1' },
        { name: 'Movimento de relógio com as pernas', fields: '1' },
        { name: 'Agachamento na bola bosu', fields: '1' },
        { name: 'Agachamento com peso na bola bosu', fields: '1-2' }
      ],
      flexibility: [
        { name: 'Alongamento de pescoço', fields: '1' },
        { name: 'Alongamento do flexor do quadril', fields: '1' },
        { name: 'Alongamento de tríceps', fields: '1' },
        { name: 'Alongamento de peito', fields: '1' },
        { name: 'Alongamento de glúteos', fields: '1' },
        { name: 'Alongamento de ombros puxando para frente', fields: '1' },
        { name: 'Alongamento de ombros puxando para trás', fields: '1' },
        { name: 'Alongamento de isquiotibiais passivo', fields: '1' },
        { name: 'Alongamento do quadríceps', fields: '1' },
        { name: 'Alongamento do trapézio', fields: '1' },
        { name: 'Abertura de pernas com flexão lateral', fields: '1' },
        { name: 'Agachamento frontal com puxada de pé', fields: '1' },
        { name: 'Flexão coxo-femural', fields: '1' },
        { name: 'Postura de alongamento em ângulo lateral', fields: '1' },
        { name: 'Postura do peixe com apoio', fields: '1' }
      ],
      strength: [
        # Chest
        { name: 'Supino reto', body_parts: [:chest], fields: '1-2' },
        { name: 'Supino 45', body_parts: [:chest], fields: '1-2' },
        { name: 'Supino 90', body_parts: [:chest], fields: '1-2' },
        { name: 'Supino declinado', body_parts: [:chest], fields: '1-2' },
        { name: 'Flexões', body_parts: [:chest], fields: '1-2' },
        { name: 'Supino com halteres', body_parts: [:chest], fields: '1-2' },
        { name: 'Supino reto máquina', body_parts: [:chest], fields: '1-2' },
        { name: 'Voador', body_parts: [:chest], fields: '1-2' },
        { name: 'Voador com halteres', body_parts: [:chest], fields: '1-2' },
        { name: 'Voador com halteres inclinado', body_parts: [:chest], fields: '1-2' },
        { name: 'Voador com halteres declinado', body_parts: [:chest], fields: '1-2' },
        { name: 'Crucifixo', body_parts: [:chest], fields: '1-2' },
        { name: 'Cabo crossover', body_parts: [:chest], fields: '1-2' },
        # Back
        { name: 'Puxada frontal aberta', body_parts: [:back], fields: '1-2' },
        { name: 'Puxada frontal fechada', body_parts: [:back], fields: '1-2' },
        { name: 'Puxada costas', body_parts: [:back], fields: '1-2' },
        { name: 'Remada sentado aberta', body_parts: [:back], fields: '1-2' },
        { name: 'Remada sentado fechada', body_parts: [:back], fields: '1-2' },
        { name: 'Remada cavalinho aberta', body_parts: [:back], fields: '1-2' },
        { name: 'Remada cavalinho fechada', body_parts: [:back], fields: '1-2' },
        # Shoulders
        { name: 'Ombro cabo elevação unilateral', body_parts: [:shoulders], fields: '1-2' },
        { name: 'Ombro halter elevação unilateral', body_parts: [:shoulders], fields: '1-2' },
        { name: 'Ombros halteres elevação bilateral', body_parts: [:shoulders], fields: '1-2' },
        { name: 'Ombros halteres elevação frontal', body_parts: [:shoulders], fields: '1-2' },
        { name: 'Desenvolvimento ombros barra', body_parts: [:shoulders], fields: '1-2' },
        { name: 'Desenvolvimento ombros halteres', body_parts: [:shoulders], fields: '1-2' },
        { name: 'Elevação de ombros', body_parts: [:shoulders], fields: '1-2' },
        # Triceps
        { name: 'Tríceps máquina barra reta', body_parts: [:triceps], fields: '1-2' },
        { name: 'Tríceps máquina barra v', body_parts: [:triceps], fields: '1-2' },
        { name: 'Tríceps corda', body_parts: [:triceps], fields: '1-2' },
        { name: 'Tríceps mergulho', body_parts: [:triceps], fields: '1-2' },
        { name: 'Tríceps halteres sobre os ombros', body_parts: [:triceps], fields: '1-2' },
        { name: 'Tríceps barra w sentado', body_parts: [:triceps], fields: '1-2' },
        { name: 'Tríceps barra w deitado', body_parts: [:triceps], fields: '1-2' },
        # Biceps:
        { name: 'Bíceps barra reta', body_parts: [:biceps], fields: '1-2' },
        { name: 'Bíceps barra w', body_parts: [:biceps], fields: '1-2' },
        { name: 'Bíceps halteres', body_parts: [:biceps], fields: '1-2' },
        { name: 'Bíceps halteres alternado', body_parts: [:biceps], fields: '1-2' },
        { name: 'Bíceps halteres martelo', body_parts: [:biceps], fields: '1-2' },
        { name: 'Bíceps halteres rotacionado', body_parts: [:biceps], fields: '1-2' },
        { name: 'Bíceps barra w banco scott', body_parts: [:biceps], fields: '1-2' },
        { name: 'Bíceps halteres banco scott', body_parts: [:biceps], fields: '1-2' },
        { name: 'Bíceps halteres martelo banco scott', body_parts: [:biceps], fields: '1-2' },
        # Abdomen:
        { name: 'Abdominais', body_parts: [:abdomen], fields: '1' },
        { name: 'Abdominais com peso', body_parts: [:abdomen], fields: '1-2' },
        { name: 'Abdominais máquina', body_parts: [:abdomen], fields: '1-2' },
        { name: 'Abdominais reversos', body_parts: [:abdomen], fields: '1' },
        { name: 'Abdominais girando', body_parts: [:abdomen], fields: '1' },
        { name: 'Abdominais banco', body_parts: [:abdomen], fields: '1' },
        { name: 'Abdominais levantamento de pernas frontal', body_parts: [:abdomen], fields: '1' },
        { name: 'Abdominais levantamento de pernas lateral', body_parts: [:abdomen], fields: '1' },
        { name: 'Abdominais joelhos no peito', body_parts: [:abdomen], fields: '1' },
        # Legs:
        { name: 'Agachamento com barra', body_parts: [:legs], fields: '1-2' },
        { name: 'Agachamento com barra frontal', body_parts: [:legs], fields: '1-2' },
        { name: 'Agachamento máquina', body_parts: [:legs], fields: '1-2' },
        { name: 'Leg press 45', body_parts: [:legs], fields: '1-2' },
        { name: 'Cadeira extensora', body_parts: [:legs], fields: '1-2' },
        { name: 'Cadeira adutora', body_parts: [:legs], fields: '1-2' },
        { name: 'Cadeira abdutora', body_parts: [:legs], fields: '1-2' },
        { name: 'Mesa flexora', body_parts: [:legs], fields: '1-2' },
        { name: 'Máquina de glúteos', body_parts: [:legs], fields: '1-2' },
        { name: 'Máquina de panturrilhas', body_parts: [:legs], fields: '1-2' },
        { name: 'Levantamento de barra', body_parts: [:legs], fields: '1-2' }
      ]
    }
  end

  def initial_exercise_map_en
    {
      aerobic: [
        { name: 'Walking', fields: '3-4' },
        { name: 'Running', fields: '3-4' },
        { name: 'Swimming', fields: '3-4' },
        { name: 'Aquarobics', fields: '3' },
        { name: 'Cycling', fields: '3-4' },
        { name: 'Rowing', fields: '3-4' },
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
end
