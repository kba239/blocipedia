require 'rails_helper'

RSpec.describe Collaboration, type: :model do
  let(:collaboration) { create(:collaborator) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:wiki) }

end
