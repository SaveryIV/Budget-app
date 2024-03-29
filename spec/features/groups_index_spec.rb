require 'rails_helper'

RSpec.describe 'when opening the group\'s index page', type: :feature do
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
    visit(groups_path)
  end

  it 'shows the correct heading' do
    expect(page).to have_content('Categories')
  end

  it 'shows the names of each group' do
    expect(page).to have_content('Food')
    expect(page).to have_content('Cosmetics')
  end

  it 'shows the icons of each group' do
    expect(page).to have_css("img[src='#{@group1.icon}']")
    expect(page).to have_css("img[src='#{@group2.icon}']")
  end

  it 'shows the created_at attribute of each group' do
    expect(page).to have_content(Date.today.strftime('%d %b %Y'), count: 2)
  end

  it 'shows the add category button' do
    expect(page).to have_link('add category', href: new_group_path)
  end

  context 'clicks on a group name' do
    it 'redirects to that group\'s transactions page' do
      click_link('Food')
      expect(page).to have_current_path(group_shoppings_path(@group1))
    end

    it 'redirects to that group\'s transactions page' do
      click_link('Cosmetics')
      expect(page).to have_current_path(group_shoppings_path(@group2))
    end
  end

  context 'clicks on a add group button' do
    it 'redirects to form that adds new group' do
      click_link('add category')
      expect(page).to have_current_path(new_group_path)
    end
  end
end
