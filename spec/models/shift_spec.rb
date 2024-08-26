RSpec.describe Shift do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:end) }
    it { is_expected.to validate_presence_of(:profession) }
    it { is_expected.to validate_presence_of(:start) }
  end
end
