RSpec.describe ExceptionHandler, type: :controller do
  controller(ApplicationController) do
    include ExceptionHandler

    def index; end
  end

  before do
    allow(@controller).to receive(:index).and_raise(error)
  end

  subject { get :index, params: { error: error } }

  context 'when raises a StandardError' do
    let(:error) { StandardError.new('message') }

    it { expect(subject).to have_http_status(:internal_server_error) }
  end

  context 'when raises a ActiveRecord::RecordInvalid' do
    let(:error) { ActiveRecord::RecordInvalid }

    it { expect(subject).to have_http_status(:unprocessable_entity) }
  end

  context 'when raises a ActiveRecord::RecordNotFound' do
    let(:error) { ActiveRecord::RecordNotFound }

    it { expect(subject).to have_http_status(:not_found) }
  end

  context 'when raises a ArgumentError' do
    let(:error) { ArgumentError }

    it { expect(subject).to have_http_status(:bad_request) }
  end
end
