RSpec.describe ShiftRepository do
  describe '.shifts_for_worker_and_facility' do
    let(:worker) { create(:worker) }
    let(:profession) { worker.profession }
    let(:facility) { create(:facility) }
    let(:start_date) { Time.zone.today }
    let(:end_date) { 7.days.since }

    let!(:shift) do
      create(
        :shift,
        :unclaimed,
        facility: facility,
        profession: profession,
        start: start_date + 1.day,
        ends_at: end_date - 1.day
      )
    end

    subject { described_class.shifts_for_worker_and_facility(worker, facility, start_date, end_date) }

    it { is_expected.to contain_exactly(shift) }

    context 'when shift is inactive' do
      let!(:shift) { create(:shift, :inactive, facility: facility, profession: profession) }

      it { is_expected.to be_empty }
    end

    context 'when shift is claimed' do
      let!(:shift) { create(:shift, facility: facility, profession: profession, worker: worker) }

      it { is_expected.to be_empty }
    end

    context 'when shift does not have facility' do
      let!(:shift) { create(:shift, :unclaimed, profession: profession) }

      it { is_expected.to be_empty }
    end

    context 'when shift has another profession' do
      let!(:shift) { create(:shift, :unclaimed, profession: 'CNA', facility: facility) }

      it { is_expected.to be_empty }
    end

    context 'when shift is outside date range' do
      let!(:shift) { create(:shift, :unclaimed, facility: facility, profession: profession, ends_at: 10.days.since) }

      it { is_expected.to be_empty }
    end

    context 'when worker has a shift overlapping the date range' do
      let!(:worker_shift) do
        create(
          :shift,
          :unclaimed,
          facility: facility,
          profession: profession,
          worker: worker,
          start: worker_shift_start,
          ends_at: worker_shift_end
        )
      end

      context 'when shift starts before worker shift and finishs during worker shift' do
        let(:worker_shift_start) { start_date - 2.day }
        let(:worker_shift_end) { start_date + 2.day }

        it { is_expected.to be_empty }
      end

      context 'when shift starts during worker shift and finishs after worker shift' do
        let(:worker_shift_start) { start_date + 2.day }
        let(:worker_shift_end) { end_date + 2.day }

        it { is_expected.to be_empty }
      end

      context 'when shift starts before worker shift and finishs after worker shift' do
        let(:worker_shift_start) { start_date - 2.day }
        let(:worker_shift_end) { end_date + 2.day }

        it { is_expected.to be_empty }
      end

      context 'when shift starts during worker shift and finishs during worker shift' do
        let(:worker_shift_start) { start_date + 2.day }
        let(:worker_shift_end) { end_date - 2.day }

        it { is_expected.to be_empty }
      end
    end
  end
end
