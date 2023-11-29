require 'rails_helper'

RSpec.describe 'Shoppings', type: :request do
  let(:group) { Group.create(user: @user, name: 'Food', icon: 'missing_avatar.png') }
  let(:shopping) { Shopping.create(name: 'Apples', amount: 5, author: @user) }
  let(:group_shopping) { GroupShopping.create(group: group, shopping: shopping) }
  let(:valid_attributes) { { 'name' => 'Bananas', 'amount' => 5, 'author' => @user, 'group_ids' => [group.id] } }

  before :each do
    @user = User.create(name: 'Tom', email: 'tom@example.com', password: 'topsecret')
    login(@user)
  end

  context 'GET /index' do
    before :each do
      get group_shoppings_url(group)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the right view file' do
      expect(response).to render_template(:index)
    end

    it 'renders the right placeholder' do
      expect(response.body).to include('<h1>Transactions</h1>')
    end
  end

  context 'GET /show' do
    before :each do
      get group_shopping_url(group, shopping)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the right view file' do
      expect(response).to render_template(:show)
    end

    it 'renders the right placeholder' do
      expect(response.body).to include('<h1>Purchase Details</h1>')
      expect(response.body).to include('<span class="name">Apples</span>')
    end
  end

  context 'GET /new' do
    before :each do
      get new_group_shopping_url(group)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the right view file' do
      expect(response).to render_template(:new)
    end

    it 'renders the right placeholder' do
      expect(response.body).to include('<h1>New Transaction</h1>')
    end
  end

  context 'GET /create' do
    it 'returns http redirect response' do
      post group_shoppings_path(group), params: { shopping: valid_attributes }
      expect(response.status).to eq(302)
    end

    it 'creates a purchase' do
      expect do
        post group_shoppings_path(group), params: { shopping: valid_attributes }
      end.to change(Shopping, :count).by(1)
    end

    it 'redirects to a page' do
      post group_shoppings_path(group), params: { shopping: valid_attributes }
      expect(response).to redirect_to group_shoppings_path(group)
    end
  end

  context 'GET /edit' do
    before :each do
      get edit_group_shopping_url(group, shopping)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the right view file' do
      expect(response).to render_template(:edit)
    end

    it 'renders the right placeholder' do
      expect(response.body).to include('<h1>Edit transaction</h1>')
    end
  end

  def login(user)
    post new_user_session_path, params: {
      user: {
        email: user.email, password: user.password
      }
    }
    follow_redirect!
  end
end