require 'rails_helper'

RSpec.describe GroupEventsController, type: :controller do
  describe 'GET index' do
    let!(:group_event) { create(:group_event) }

    it 'returns success' do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:group_events).size).to be > 0
    end
  end

  describe 'GET show' do
    let!(:group_event) { create(:group_event) }

    it 'returns success if exists' do
      get :show, params: { id: group_event.id }
      expect(response).to have_http_status(:success)
      expect(assigns(:group_event)).to eq(group_event)
    end

    it 'returns 404 if not exists' do
      get :show, params: { id: group_event.id + 1 }
      expect(response).to have_http_status(404)
      expect(assigns(:group_event)).to eq(nil)
    end
  end

  describe 'POST create' do
    it 'returns success if valid' do
      expect{ post :create }.to change{ GroupEvent.count }.by(1)
      expect(response).to have_http_status(201)
    end

    it 'returns 422 if invalid' do
      post :create, params: { published: true }
      expect(response).to have_http_status(422)
    end
  end

  describe 'PUT update' do
    let!(:group_event) { create(:group_event) }

    it 'updates the record' do
      put :update, params: { id: group_event.id, name: 'Update Name' }

      expect(response.body).to be_empty
      expect(response).to have_http_status(204)
    end
  end

  describe 'DELETE destroy' do
    let!(:group_event) { create(:group_event) }

    it 'returns success' do
      delete :destroy, params: { id: group_event.id }
      expect(response).to have_http_status(204)
      group_event.reload
      expect(group_event.deleted).to eq(true)
    end
  end
end
