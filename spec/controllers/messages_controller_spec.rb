require 'rails_helper'

describe MessagesController do
  describe 'GET #index' do
    let(:user) { create(:user) }
    let(:group) { create(:group) }

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
      it "renders the new_user_session template" do
        get :index, params: { group_id: group.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:group) { create(:group) }
    let(:message) {build(:message)}

    context 'log in' do
      before do
        login user
      end

      context 'valid message params' do
        it 'message save success' do
          post :create, params: {
            message: {
              body: message.body,
              image: message.image
            },
            user_id: user.id,
            group_id: group.id
          }
          expect(assigns(:message)).to be_valid
        end

        it "renders the group_messages template" do
          post :create, params: {
            message: {
              body: message.body,
              image: message.image
            },
            user_id: user.id,
            group_id: group.id
          }
          expect(response).to redirect_to group_messages_path
        end
      end

      context 'invalid message params' do
        it 'message save fail' do
          post :create, params: {
            message: {
              body: nil,
              image: nil
            },
            user_id: user.id,
            group_id: group.id
          }
          expect(assigns(:message)).not_to be_valid
        end

        it "renders the group_messages template" do
          post :create, params: {
            message: {
              body: message.body,
              image: message.image
            },
            user_id: user.id,
            group_id: group.id
          }
          expect(response).to redirect_to group_messages_path
        end
      end
    end

    context 'not log in' do
      it "renders the new_user_session template" do
        post :create, params: { group_id: group.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end