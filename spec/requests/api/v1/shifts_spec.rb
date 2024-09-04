require 'swagger_helper'

RSpec.describe 'Api::V1::ShiftsController', type: :request do
  path '/api/v1/shifts' do
    get 'Retrieves available shifts' do
      tags 'Shifts'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :worker_id, in: :query, type: :integer, required: true, example: 1
      parameter name: :facility_id, in: :query, type: :integer, required: true, example: 1
      parameter name: :start_date, in: :query, type: :string, required: true, format: 'date-time'
      parameter name: :end_date, in: :query, type: :string, required: true, format: 'date-time'
      parameter name: :page, in: :query, type: :integer, required: false, default: 1
      parameter name: :per_page, in: :query, type: :integer, required: false, default: 10

      response '200', 'shifts found' do
        schema '$ref' => '#/schemas/shifts'

        let(:worker) { create(:worker) }
        let(:worker_id) { worker.id }
        let(:facility) { create(:facility) }
        let(:facility_id) { facility.id }
        let(:start_date) { Time.zone.today }
        let(:end_date) { 7.days.since }
        let(:page) { 1 }
        let(:per_page) { 10 }
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

        it 'returns available shifts' do |example|
          expect { submit_request(example.metadata) }.not_to raise_error

          expect(response).to be_ok
        end
      end
    end
  end
end
