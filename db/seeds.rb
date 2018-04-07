# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
exercises = {
  aerobic: 'Aerobic, or endurance, are activities that increase your breathing and heart rate. They keep your heart, lungs, and circulatory system healthy and improve your overall fitness. Building your endurance makes it easier to carry out many of your everyday activities.',
  strength: 'Strength exercises make your muscles stronger. They may help you stay independent and carry out everyday activities, such as climbing stairs and carrying groceries. These exercises also are called strength training or resistance training.',
  balance: 'Balance exercises help prevent falls, a common problem in older adults. Many lower-body strength exercises also will improve your balance.',
  flexibility: 'Flexibility exercises stretch your muscles and can help your body stay limber. Being flexible gives you more freedom of movement for other exercises as well as for your everyday activities.'
}

exercises.each do |key, value|
  ExerciseCategory.create(name: key.to_s.capitalize, description: value)
end
