RSpec.describe Document do
  describe 'associations' do
    it { is_expected.to have_many(:facility_requirements).dependent(:destroy) }
    it { is_expected.to have_many(:facilities).through(:facility_requirements) }
    it { is_expected.to have_many(:document_workers).dependent(:destroy) }
    it { is_expected.to have_many(:workers).through(:document_workers) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
