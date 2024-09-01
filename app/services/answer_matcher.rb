class AnswerMatcher
  def self.match?(user_answer, correct_answer)
    user_answer = preprocess(user_answer)
    correct_answer = preprocess(correct_answer)

    return true if user_answer == correct_answer
    return true if correct_answer.include?(user_answer) && user_answer.length > 3
    return true if user_answer.include?(correct_answer) && correct_answer.length > 3

    correct_parts = correct_answer.split.map { |part| preprocess(part) }
    user_parts = user_answer.split.map { |part| preprocess(part) }

    return true if (correct_parts - user_parts).empty?
    return true if (user_parts - correct_parts).empty?

    correct_initials = correct_parts.map { |part| part[0] }.join
    user_initials = user_parts.map { |part| part[0] }.join

    return true if correct_initials == user_initials && user_initials.length > 2

    levenshtein_distance(user_answer, correct_answer) <= [correct_answer.length / 3, 3].max
  end

  def self.preprocess(text)
    text.downcase
        .gsub(/[^\w\s]/, '') # Remove punctuation
        .gsub(/\b(a|an|the)\b/, '') # Remove articles
        .gsub(/\(.*?\)/, '') # Remove parenthetical content
        .split('-').first # Take only the part before a dash
      &.strip
  end

  def self.levenshtein_distance(s, t)
    m = s.length
    n = t.length
    return m if n == 0
    return n if m == 0
    d = Array.new(m+1) {Array.new(n+1)}

    (0..m).each {|i| d[i][0] = i}
    (0..n).each {|j| d[0][j] = j}
    (1..n).each do |j|
      (1..m).each do |i|
        d[i][j] = if s[i-1] == t[j-1]
                    d[i-1][j-1]
                  else
                    [d[i-1][j]+1,d[i][j-1]+1,d[i-1][j-1]+1].min
                  end
      end
    end
    d[m][n]
  end
end

# Usage:
# AnswerMatcher.match?(user_answer, correct_answer)