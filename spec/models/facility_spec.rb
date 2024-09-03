RSpec.describe Facility do
  describe 'associations' do
    it { is_expected.to have_many(:facility_requirements).dependent(:destroy) }
    it { is_expected.to have_many(:documents).through(:facility_requirements) }
    it { is_expected.to have_many(:shifts).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
