RSpec.describe FacilityRequirement do
  describe 'associations' do
    it { is_expected.to belong_to(:document) }
    it { is_expected.to belong_to(:facility) }
  end
end
