require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context 'associations' do
    it { should belong_to :invoice }
  end
end
