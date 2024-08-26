RSpec.describe DocumentWorker do
  describe 'associations' do
    it { is_expected.to belong_to(:document) }
    it { is_expected.to belong_to(:worker) }
  end
end
