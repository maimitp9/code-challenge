# frozen_string_literal: true

module Admin
  module Api
    class UsersController < ::Admin::Api::ApplicationController
      before_action :set_user, only: %i[show update destroy]

      def index
        users = User.where.not(id: current_user.id)

        render json: users, status: :ok
      end

      def create
        user = User.new(user_params)
        render_active_model_errors(user) and return if user.invalid?

        user.save!

        render json: user, status: :created
      end

      def show
        render json: @user, status: :ok
      end

      def update
        @user.assign_attributes(user_params)
        render_active_model_errors(@user) and return if @user.invalid?

        @user.save!

        render json: @user, status: :ok
      end

      def destroy
        @user.update!(status: 'inactive')

        head :no_content
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
      end

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end
