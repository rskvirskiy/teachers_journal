require 'spec_helper'

describe GroupsController do
  fixtures :users, :groups

  let(:user) { users(:teacher) }
  let!(:group) { groups(:sp_group) }

  before { sign_in user }

  it 'edit should returns success' do
    get :edit, id: group.id
    expect(response.status).to eq(200)
    expect(response).to render_template('edit')
  end

  it 'new should returns success' do
    get :new
    expect(response.status).to eq(200)
    expect(response).to render_template('new')
  end

  describe '#create' do
    let(:invalid_params) { { group: { name: '', students_number: 22 } } }
    let(:valid_params) { { group: { name: 'test', students_number: 22 } } }

    it 'with invalid params should rerender new' do
      post :create, invalid_params

      expect(response).to render_template('new')
    end

    it 'with valid params should redirect and show flash message' do
      post :create, valid_params

      expect(response).to redirect_to(groups_url)
      expect(flash[:notice]).to match(/created/)
    end
  end

  describe '#update' do
    it 'should redirect and show flash message' do
      patch :update, { id: group.id, group: { name: 'sp updated', students_number: 22 } }

      expect(response).to redirect_to(groups_url)
      expect(flash[:notice]).to match(/updated/)
    end
  end
end