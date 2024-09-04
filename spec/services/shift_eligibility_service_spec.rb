RSpec.describe ShiftEligibilityService do
  describe '.new' do
    let(:worker_id) { double }
    let(:facility_id) { double }
    let(:start_date) { double }
    let(:end_date) { double }

    subject { described_class.new(worker_id, facility_id, start_date, end_date) }

    it 'sets @worker_id' do
      expect(subject.instance_variable_get(:@worker_id)).to eq(worker_id)
    end

    it 'sets @facility_id' do
      expect(subject.instance_variable_get(:@facility_id)).to eq(facility_id)
    end

    it 'sets @start_date' do
      expect(subject.instance_variable_get(:@start_date)).to eq(start_date)
    end

    it 'sets @end_date' do
      expect(subject.instance_variable_get(:@end_date)).to eq(end_date)
    end
  end

  describe '#shifts_by_worker_and_facility' do
    let(:worker) { create(:worker) }
    let(:facility) { create(:facility) }
    let(:start_date) { Time.zone.today }
    let(:end_date) { 7.days.since }

    subject { described_class.new(worker.id, facility.id, start_date, end_date).shifts_by_worker_and_facility }

    context 'when shift exists' do
      let!(:shift) do
        create(
          :shift,
          :unclaimed,
          facility: facility,
          profession: worker.profession,
          start: start_date.next_day,
          ends_at: end_date.prev_day
        )
      end

      it { is_expected.to contain_exactly(shift) }
    end

    context 'when worker not found' do
      let(:worker) { double(id: 0) }

      it { expect { subject }.to raise_error(ArgumentError, 'worker not found or inactive') }
    end

    context 'when worker is inactive' do
      let(:worker) { create(:worker, :inactive) }

      it { expect { subject }.to raise_error(ArgumentError, 'worker not found or inactive') }
    end

    context 'when facility not found' do
      let(:facility) { double(id: 0) }

      it { expect { subject }.to raise_error(ArgumentError, 'facility not found or inactive') }
    end

    context 'when facility is inactive' do
      let(:facility) { create(:facility, :inactive) }

      it { expect { subject }.to raise_error(ArgumentError, 'facility not found or inactive') }
    end

    context 'when start_date is blank' do
      let(:start_date) { nil }

      it { expect { subject }.to raise_error(ArgumentError, 'start_date is required') }
    end

    context 'when end_date is blank' do
      let(:end_date) { nil }

      it { expect { subject }.to raise_error(ArgumentError, 'end_date is required') }
    end

    context 'when worker missing documents for facility' do
      let(:document) { create(:document) }

      before { create(:facility_requirement, facility: facility, document: document) }

      it { expect { subject }.to raise_error(ArgumentError, "worker missing documents for facility: #{[document.id]}") }
    end
  end
end
