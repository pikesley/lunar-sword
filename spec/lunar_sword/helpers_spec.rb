class TestHelper
  include LunarSword::Helpers
end

module LunarSword
  describe Helpers do
    let(:helpers) { TestHelper.new }

    it 'has a config' do
      expect(CONFIG).to be_a Hash
    end
  end
end
