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

  describe 'scopes' do
    describe '.active' do
      subject { Shift.active }

      context 'when shift is active' do
        let!(:shift) { create(:shift) }

        it { is_expected.to contain_exactly(shift) }
      end

      context 'when shift is inactive' do
        let!(:shift) { create(:shift, :inactive) }

        it { is_expected.to be_empty }
      end
    end

    describe '.unclaimed' do
      subject { Shift.unclaimed }

      context 'when shift is unclaimed' do
        let!(:shift) { create(:shift, :unclaimed) }

        it { is_expected.to contain_exactly(shift) }
      end

      context 'when shift is claimed' do
        let!(:shift) { create(:shift, worker: create(:worker)) }

        it { is_expected.to be_empty }
      end
    end

    describe '.with_facility' do
      let(:facility) { create(:facility) }

      subject { Shift.with_facility(facility) }

      context 'when shift has facility' do
        let!(:shift) { create(:shift, facility: facility) }

        it { is_expected.to contain_exactly(shift) }
      end

      context 'when shift does not have facility' do
        let!(:shift) { create(:shift) }

        it { is_expected.to be_empty }
      end
    end

    describe '.with_date_range' do
      let(:start) { 1.day.ago }
      let(:ends_at) { 1.day.since }

      subject { Shift.with_date_range(start, ends_at) }

      context 'when shift is within date range' do
        let!(:shift) { create(:shift, start: start + 1.hour, ends_at: ends_at - 1.hour) }

        it { is_expected.to contain_exactly(shift) }
      end

      context 'when shift is outside date range' do
        let!(:shift) { create(:shift, start: 2.days.ago, ends_at: 2.days.ago) }

        it { is_expected.to be_empty }
      end
    end

    describe '.with_profession' do
      let(:profession) { 'RN' }

      subject { Shift.with_profession(profession) }

      context 'when shift has profession' do
        let!(:shift) { create(:shift, profession: profession) }

        it { is_expected.to contain_exactly(shift) }
      end

      context 'when shift does not have profession' do
        let!(:shift) { create(:shift) }

        it { is_expected.to be_empty }
      end
    end
  end
end
