if Clue.count.zero?
  start = Time.now
  puts "Seeding Jeopardy clues..."
  clues = []
  answers = []

  jeopardy = JSON.parse(File.read(Rails.root.join('lib', 'assets', 'jeopardy_questions.json')))
  jeopardy.each do |question|
    clues << question.except('answer')
    answers << { answer: question['answer'] }
  end

  # bulk insert clues
  clue_results = Clue.insert_all(clues, returning: [:id])

  answers_with_clue_ids = answers.zip(clue_results.rows).map do |answer, clue_result|
    answer.merge(clue_id: clue_result[0])
  end

  # Bulk insert Answers
  Answer.insert_all(answers_with_clue_ids)

  puts "Seeded #{Clue.count} clues and answers in #{Time.now - start}s."
else
  puts "Jeopardy clues have already been seeded. Skipping..."
end