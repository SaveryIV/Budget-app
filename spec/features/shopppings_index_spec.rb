require 'rails_helper'

RSpec.describe 'when opening the shopping index page', type: :feature do
  before(:each) do
    @user = User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret')

    visit new_user_session_path
    fill_in 'Email', with: 'tom@example.com'
    fill_in 'Password', with: 'topsecret'
    click_button 'Log in'

    @group1 = Group.create(user: @user, name: 'Food', icon: 'https://i.pravatar.cc/300?img=13')
    @group2 = Group.create(user: @user, name: 'Cosmetics', icon: 'https://i.pravatar.cc/300?img=1')
    @shopping1 = Shopping.create(name: 'Apples', amount: 6, author: @user, groups: [@group1])
    @shopping2 = Shopping.create(name: 'Bananas', amount: 4, author: @user, groups: [@group1])
    visit(group_shoppings_path(@group1))
  end

  it 'does not show incorrect heading' do
    expect(page).to_not have_content('Incorrect Heading')
  end

  it 'does not show the name of an incorrect purchase' do
    expect(page).to_not have_content('Oranges')
  end

  it 'does not show an incorrect created_at attribute for purchases' do
    expect(page).to_not have_content('01 Jan 2000')
  end

  it 'does not show an incorrect amount for purchases' do
    expect(page).to_not have_content('$8.0')
  end

  it 'does not show an incorrect total amount for the group' do
    expect(page).to_not have_content('$12.0')
  end

  it 'does not show an incorrect add transaction button' do
    expect(page).to_not have_link('add incorrect transaction', href: new_group_shopping_path(@group1))
  end

  context 'clicking on an add transaction button' do
    it 'does not redirect to an incorrect form' do
      click_link('add transaction')
      expect(page).to_not have_current_path(new_group_shopping_path(@group2))
    end
  end
end
