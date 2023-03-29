require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  describe "successfully" do
    it 'created with valid params' do
      User.create(
        name: 'Athri',
        email: 'athri@gmail.com',
        age: 30
      )
      expect(User.count).to eq(1)
    end
  end
  describe "failed" do
    it 'to be created without email' do
      User.create(
        name: 'Athri',
        age: 30
      )
      expect(User.count).to eq(0)
    end
  end
end
