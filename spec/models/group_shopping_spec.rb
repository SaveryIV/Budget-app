require 'rails_helper'

RSpec.describe GroupShopping, type: :model do
  let(:valid_attributes) { { 'user' => @user, 'name' => 'Food', 'icon' => 'missing_avatar.png' } }
  let(:no_name) { { 'user' => @user, 'icon' => 'missing_avatar.png' } }
  let(:name_too_long) { { 'user' => @user, 'name' => 'A' * 37, 'icon' => 'missing_avatar.png' } }
  let(:name_number) { { 'user' => @user, 'name' => 37, 'icon' => 'missing_avatar.png' } }
  let(:no_icon) { { 'user' => @user, 'name' => 'Food' } }
  let(:icon_number) do
    { 'user' => @user, 'name' => 'Food', 'icon' => 37 }
  end
  let(:icon_too_long) do
    { 'user' => @user, 'name' => 'Food', 'icon' => 'A' * 251 }
  end

  before :all do
    @user = User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret')
    @shopping = Shopping.create(author: @user, name: 'Apples', amount: 2)
    @group = Group.create(user: @user, name: 'Food', icon: 'missing_avatar.png')
  end

  context '#create' do
    it 'is valid when both attributes exists' do
      expect(GroupShopping.create(group: @group, shopping: @shopping)).to be_valid
    end

    it 'is not valid without group' do
      expect(GroupShopping.create(shopping: @shopping)).to_not be_valid
    end

    it 'is not valid without shopping' do
      expect(GroupShopping.create(group: @group)).to_not be_valid
    end

    it 'is not valid without shopping' do
      GroupShopping.create(group: @group, shopping: @shopping)
      expect(GroupShopping.create(group: @group, shopping: @shopping)).to_not be_valid
    end
  end
end
