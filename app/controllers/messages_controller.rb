class MessagesController < ApplicationController
  before_action :move_to_sign_in

  def index
    @groups = current_user.groups
    @group = Group.find(params[:group_id])
    @messages = @group.messages
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.body.present? || @message.image.file.present?
      if @message.image.file.present?
        resize_image(@message.image)
      end
      @message.save
    else
      flash[:alert] = "メッセージを入力してください。"
    end
    redirect_to group_messages_path
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id, group_id: params[:group_id])
  end

  def resize_image(image)
    require 'mini_magick'
    resize_image = MiniMagick::Image.open(image.current_path)
    resize_image.resize "200x200"
    resize_image.write image.current_path
  end

  def move_to_sign_in
    unless user_signed_in?
      flash[:alert] = "ログインまたは登録が必要です。"
      redirect_to new_user_session_path
    end
  end
end
