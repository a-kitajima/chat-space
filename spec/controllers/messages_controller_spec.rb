require 'rails_helper'

describe MessagesController do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let(:group) { create(:group)}

    context 'log in' do
      before do
        login user
      end

      it "populate current_user's groups" do
        get :index, params: { group_id: group.id }
        expect(assigns(:groups)).to eq user.groups
      end

      it "populate current group" do
        get :index, params: { group_id: group.id }
        expect(assigns(:group)).to eq group
      end

      it "populate current group's messages" do
        messages = create_list(:message, 3, group: group)
        get :index, params: { group_id: group.id }
        expect(assigns(:messages)).to match(messages)
      end

      it "populate new message" do
        blank_message = Message.new
        get :index, params: { group_id: group.id }
        expect(assigns(:message).attributes).to eq blank_message.attributes
      end

      it "renders the :index template" do
        get :index, params: { group_id: group.id }
        expect(response).to render_template :index
      end
    end

    context 'not log in' do
      it "renders the :new_user_session template" do
        get :index, params: { group_id: group.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end