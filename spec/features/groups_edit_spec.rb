require 'rails_helper'

RSpec.describe 'when opening the group\'s edit page', type: :feature do
  before(:each) do
    @user = User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret')

    visit new_user_session_path
    fill_in 'Email', with: 'tom@example.com'
    fill_in 'Password', with: 'topsecret'
    click_button 'Log in'

    @group1 = Group.create(user: @user, name: 'Food', icon: 'https://i.pravatar.cc/300?img=13')
    @group2 = Group.create(user: @user, name: 'Cosmetics', icon: 'https://i.pravatar.cc/300?img=1')
    @shopping1 = Shopping.create(name: 'Apples', amount: 5, author: @user, groups: [@group1])
    @shopping2 = Shopping.create(name: 'Bananas', amount: 5, author: @user, groups: [@group1])
    visit(edit_group_path(@group1))
  end
  context 'shows the correct' do
    it 'heading' do
      expect(page).to have_content('Edit Category')
    end

    it 'labels' do
      expect(page).to have_content('Name')
      expect(page).to have_content('Icon link *')
    end

    it 'placeholders' do
      expect(page).to have_css("input[value='Food']")
      expect(page).to have_css("input[value='https://i.pravatar.cc/300?img=13']")
    end

    it 'updates the category button' do
      expect(page).to have_button('update', type: 'submit')
    end
  end

  context 'fills in the fields and click on update button' do
    before(:each) do
      fill_in 'Name', with: 'Meals'
      fill_in 'Icon', with: 'https://i.pravatar.cc/300?img=6'
      click_button('update')
    end

    it 'redirects to that group\'s transactions page' do
      expect(page).to have_current_path(group_shoppings_path(@group1))
    end

    it 'group_transaction page shows the updated group' do
      expect(page).to_not have_content('Food')
      expect(page).to have_content('Meals')
    end

    it 'group_transaction page shows the updated icon' do
      expect(page).to_not have_css("img[src='https://i.pravatar.cc/300?img=5']")
      expect(page).to have_css("img[src='https://i.pravatar.cc/300?img=6']")
    end
  end
end
