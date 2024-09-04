RSpec.describe Facility do
  describe 'associations' do
    it { is_expected.to have_many(:facility_requirements).dependent(:destroy) }
    it { is_expected.to have_many(:documents).through(:facility_requirements) }
    it { is_expected.to have_many(:shifts).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'scopes' do
    describe '.active' do
      subject { Facility.active }

      context 'when facility is active' do
        let!(:facility) { create(:facility) }

        it { is_expected.to contain_exactly(facility) }
      end

      context 'when facility is inactive' do
        let!(:facility) { create(:facility, :inactive) }

        it { is_expected.to be_empty }
      end
    end
  end
end
