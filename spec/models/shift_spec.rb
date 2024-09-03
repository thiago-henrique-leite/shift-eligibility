RSpec.describe Shift do
  describe 'associations' do
    it { is_expected.to belong_to(:facility) }
    it { is_expected.to belong_to(:worker).optional }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:ends_at) }
    it { is_expected.to validate_presence_of(:profession) }
    it { is_expected.to validate_presence_of(:start) }
  end

  describe 'enums' do
    it do
      is_expected.to define_enum_for(:profession)
        .with_values(CNA: 'CNA', LVN: 'LVN', RN: 'RN')
        .backed_by_column_of_type(:string)
    end
  end
end
