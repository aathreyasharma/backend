require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  it 'creates a user' do
    User.create(
      name: 'Athri',
      email: 'athri@gmail.com',
      age: 30
    )
    expect(User.count).to eq(1)
  end

  it 'will not create a user without email' do
    User.create(
      name: 'Athri',
      age: 30
    )
    expect(User.count).to eq(0)
  end
end
