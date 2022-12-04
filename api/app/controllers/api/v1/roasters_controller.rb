class Api::V1::RoastersController < Api::ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :user_not_belonged_to_roaster_required, only: %i[create]
  before_action :user_belonged_to_roaster_required, only: %i[update destroy]
  before_action :set_roaster, only: %i[show update destroy followers]
  before_action :correct_roaster, only: %i[update destroy]

  def show
    render json: @roaster
  end

  def create
    roaster = current_api_v1_user.build_roaster(roaster_params)
    if roaster.save
      current_api_v1_user.save
      render json: { status: 'ok', data: roaster }
    else
      render json: { status: 'error', messages: roaster.errors.full_messages }
    end
  end

  def update
    return unless @roaster.update(roaster_params)

    render json: @roaster
  end

  def destroy
    @roaster.destroy
  end

  def followers
    users = @roaster.followers
    render json: users
  end

  private

  def roaster_params
    params
      .require(:roaster)
      .permit(
        :name,
        :phone_number,
        :prefecture_code,
        :address,
        :describe,
        :image,
        :image_cache,
      )
  end

  def set_roaster
    @roaster = Roaster.find(params[:id])
  end

  def correct_roaster
    return if current_api_v1_user.belonged_roaster?(@roaster)

    render json: { status: 'error', message: '所属していないロースターの更新・削除はできません' }
  end
end
