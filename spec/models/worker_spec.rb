RSpec.describe Worker do
  describe 'associations' do
    it { is_expected.to have_many(:document_workers).dependent(:destroy) }
    it { is_expected.to have_many(:documents).through(:document_workers) }
    it { is_expected.to have_many(:shifts).dependent(:destroy) }
    it { is_expected.to have_many(:facilities).through(:documents) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:profession) }
  end

  describe 'enums' do
    it do
      is_expected.to define_enum_for(:profession)
        .with_values(CNA: 'CNA', LVN: 'LVN', RN: 'RN')
        .backed_by_column_of_type(:string)
    end
  end

  describe 'scopes' do
    describe '.active' do
      subject { Worker.active }

      context 'when worker is active' do
        let!(:worker) { create(:worker) }

        it { is_expected.to contain_exactly(worker) }
      end

      context 'when worker is inactive' do
        let!(:worker) { create(:worker, :inactive) }

        it { is_expected.to be_empty }
      end
    end
  end
end
