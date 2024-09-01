require 'rails_helper'

RSpec.describe AnswerMatcher do
  describe '#match?' do
    context 'with success' do
      it 'returns true for matching answers' do
        expect(AnswerMatcher.match?('hello world', 'Hello World')).to be true
        expect(AnswerMatcher.match?('World', 'Hello World')).to be true
        expect(AnswerMatcher.match?('Hi', 'Hello World')).to be false
        expect(AnswerMatcher.match?('Hello Beautiful World', 'World')).to be true
        expect(AnswerMatcher.match?('World Hello', 'Hello World')).to be true
        expect(AnswerMatcher.match?('The Hello Beautiful World', 'Hello World')).to be true
        expect(AnswerMatcher.match?('Hello World', 'The Hello Beautiful World')).to be true
      end

      it 'returns true for answers within acceptable Levenshtein distance' do
        expect(AnswerMatcher.match?('Helo World', 'Hello World')).to be true
      end

      it 'returns false for answers beyond acceptable Levenshtein distance' do
        expect(AnswerMatcher.match?('Goodbye Moon', 'Hello World')).to be false
      end

      context 'when answers contain punctuation or special characters' do
        it 'ignores punctuation when matching' do
          expect(AnswerMatcher.match?('Hello, World!', 'Hello World')).to be true
        end

        it 'ignores parenthetical content when matching' do
          expect(AnswerMatcher.match?('Hello (beautiful) World', 'Hello World')).to be true
        end
      end

      context 'when answers contain articles' do
        it 'ignores articles when matching' do
          expect(AnswerMatcher.match?('The Hello World', 'A Hello World')).to be true
        end
      end

      context 'when answers contain hyphens' do
        it 'takes only the part before a dash' do
          expect(AnswerMatcher.match?('Hello-Goodbye World', 'Hello World')).to be true
        end
      end

      context 'edge cases' do
        it 'handles empty strings' do
          expect(AnswerMatcher.match?('', '')).to be true
          expect(AnswerMatcher.match?('Hello', '')).to be false
          expect(AnswerMatcher.match?('', 'Hello')).to be false
        end

        it 'handles very long strings' do
          long_string = 'Hello ' * 100 + 'World'
          expect(AnswerMatcher.match?(long_string, long_string)).to be true
          expect(AnswerMatcher.match?(long_string, 'Hello World')).to be false
        end

        it 'handles non-ASCII characters' do
          expect(AnswerMatcher.match?('Héllö Wörld', 'Hello World')).to be true
        end
      end
    end

    context 'with failure' do
      it 'returns false for non-matching answers' do
        expect(AnswerMatcher.match?('Happy Wonderful Day', 'Hungry White Dog')).to be false
        expect(AnswerMatcher.match?('Happy World', 'Hello World')).to be false
      end
    end
  end

  # describe '.preprocess' do
  #   it 'converts text to lowercase' do
  #     expect(AnswerMatcher.preprocess('HELLO WORLD')).to eq('hello world')
  #   end
  #
  #   it 'removes punctuation' do
  #     expect(AnswerMatcher.preprocess('Hello, World!')).to eq('hello world')
  #   end
  #
  #   it 'removes articles' do
  #     expect(AnswerMatcher.preprocess('The Hello World')).to eq('hello world')
  #   end
  #
  #   it 'removes parenthetical content' do
  #     expect(AnswerMatcher.preprocess('Hello (beautiful) World')).to eq('hello world')
  #   end
  #
  #   it 'takes only the part before a dash' do
  #     expect(AnswerMatcher.preprocess('Hello-Goodbye World')).to eq('hello')
  #   end
  #
  #   it 'strips leading and trailing whitespace' do
  #     expect(AnswerMatcher.preprocess('  Hello World  ')).to eq('hello world')
  #   end
  # end
  #
  # describe '.levenshtein_distance' do
  #   it 'returns 0 for identical strings' do
  #     expect(AnswerMatcher.levenshtein_distance('hello', 'hello')).to eq(0)
  #   end
  #
  #   it 'returns the correct distance for similar strings' do
  #     expect(AnswerMatcher.levenshtein_distance('kitten', 'sitting')).to eq(3)
  #   end
  #
  #   it 'returns the length of the other string when one string is empty' do
  #     expect(AnswerMatcher.levenshtein_distance('', 'hello')).to eq(5)
  #     expect(AnswerMatcher.levenshtein_distance('world', '')).to eq(5)
  #   end
  #
  #   it 'handles very different strings' do
  #     expect(AnswerMatcher.levenshtein_distance('abc', 'xyz')).to eq(3)
  #   end
  # end
end