require 'csv'
require 'json'

namespace :convert do
  desc "Do something with the Clue model"
  task :tsv_to_json => :environment do
    files = ['kids_teen_matches.tsv', 'more-jeopardy-questions.tsv']

    files.each do |file|
      start = Time.now
      path = Rails.root.join('lib', 'assets', file)
      clues = []
      answers = []
      i = 0
      CSV.foreach(path, headers: true, col_sep: "\t", liberal_parsing: true) do |row|
        new_row = row.to_h

        new_row['value'] = "$#{new_row['clue_value']}"
        question = new_row['answer']
        new_row['answer'] = new_row['question']
        new_row['question'] = question

        clues << new_row.to_h.except('comments', 'daily_double_value', 'notes', 'clue_value', 'round', 'answer')
        answers << { answer: new_row['answer'] }
        i += 1
      end

      clue_results = Clue.insert_all(clues, returning: [:id])

      answers_with_clue_ids = answers.zip(clue_results.rows).map do |answer, clue_result|
        answer.merge(clue_id: clue_result[0])
      end

      Answer.insert_all(answers_with_clue_ids)

      puts "Seeded #{i} clues and answers in #{Time.now - start}s."
    end
  end
end
