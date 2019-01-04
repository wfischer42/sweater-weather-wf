require 'rails_helper'

RSpec.describe Location, type: :model do
  context 'Validations' do
    it { is_expected.to validate_numericality_of(:lat) }
    it { is_expected.to validate_numericality_of(:lon) }
  end
end
