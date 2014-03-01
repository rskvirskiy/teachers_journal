require 'spec_helper'

describe SubjectsController do
  fixtures :users, :subjects

  let(:user) { users(:teacher) }
  let!(:subject) { subjects(:subject) }

  before { sign_in user }

  it 'edit should returns success' do
    get :edit, id: subject.id
    expect(response.status).to eq(200)
    expect(response).to render_template('edit')
  end

  it 'new should returns success' do
    get :new
    expect(response.status).to eq(200)
    expect(response).to render_template('new')
  end

  describe '#create' do
    let(:invalid_params) { { subject: { name: ''} } }
    let(:valid_params) { { subject: { name: 'test'} } }

    it 'with invalid params should rerender new' do
      post :create, invalid_params

      expect(response).to render_template('new')
    end

    it 'with valid params should redirect and show flash message' do
      post :create, valid_params

      expect(response).to redirect_to(subjects_url)
      expect(flash[:notice]).to match(/created/)
    end
  end

  describe '#update' do
    it 'should redirect and show flash message' do
      patch :update, { id: subject.id, subject: { name: 'test'} }

      expect(response).to redirect_to(subjects_url)
      expect(flash[:notice]).to match(/updated/)
    end
  end
end