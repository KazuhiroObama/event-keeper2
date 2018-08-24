class UsersController < ApplicationController
  before_action :set_event, only: [:show]

  def show
  end

  private
    def set_event
      @user = User.find(params[:id])
    end

    def event_params
      params.require(:user).permit(:email)
    end
end
