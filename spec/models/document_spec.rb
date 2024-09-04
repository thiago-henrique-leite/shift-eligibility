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

  describe 'scopes' do
    describe '.active' do
      subject { Document.active }

      context 'when document is active' do
        let!(:document) { create(:document) }

        it { is_expected.to contain_exactly(document) }
      end

      context 'when document is inactive' do
        let!(:document) { create(:document, :inactive) }

        it { is_expected.to be_empty }
      end
    end
  end
end
