RSpec.describe Document do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
