if Clue.count.zero?
  puts "Seeding Jeopardy clues..."

  jeopardy = JSON.parse(File.read(Rails.root.join('lib', 'assets', 'jeopardy_questions.json')))
  Clue.insert_all(jeopardy)

  puts "Seeded #{Clue.count} clues."
else
  puts "Jeopardy clues have already been seeded. Skipping..."
end