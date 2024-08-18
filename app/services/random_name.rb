class RandomName
  FIRST_NAMES = [
    "Alex", "Jamie", "Jordan", "Taylor", "Casey", "Morgan", "Riley", "Avery",
    "Quinn", "Skyler", "Charlie", "Frankie", "Kendall", "Peyton", "Sawyer"
  ]

  def self.generate
    "#{FIRST_NAMES.sample}"
  end
end