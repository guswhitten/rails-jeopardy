require 'rails_helper'

RSpec.describe RandomName do
  describe '.generate' do
    it 'returns a name from the FIRST_NAMES array' do
      100.times do
        expect(RandomName::FIRST_NAMES).to include(RandomName.generate)
      end
    end

    it 'returns different names over multiple calls' do
      names = Set.new
      100.times { names.add(RandomName.generate) }
      expect(names.size).to be > 1
    end
  end
end