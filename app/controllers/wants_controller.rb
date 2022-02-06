class WantsController < ApplicationController
  before_action :user_signed_in_required
  before_action :user_had_want_required_and_set_want, only: %i[show receipt]

  def show
    @want.offer.set_status
  end

  def create
    @offer = Offer.find(params[:offer_id])
    return if over_the_max_amount?(@offer)

    return if end_of_offering?(@offer)

    current_user.wanting_offers << @offer
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end

  def destroy
    @offer = Want.find(params[:id]).offer
    current_user.wanting_offers.delete(@offer)
    respond_to do |format|
      format.html { redirect_to request.referer }
      # Ajaxで行うとusers/wantsにてdestroyしたときにwant詳細ページへのリンクが壊れる
      # JSで非表示にするようにできたらAjaxで処理する
      # format.js
    end
  end

  def receipt
    return if already_received?(@want)

    @want.receipted_at = Time.current
    @want.save
    flash[:notice] = '受け取り完了を受け付けました'
    redirect_to @want
  end

  private

  def over_the_max_amount?(offer)
    return unless offer.wants.count >= offer.amount

    redirect_to request.referer, alert: '数量が上限に達しています'
  end

  def end_of_offering?(offer)
    return unless offer.ended_at.before? Date.current

    redirect_to request.referer, alert: 'オファーは終了しました'
  end

  def already_received?(want)
    return unless want.receipted_at?

    redirect_to want, alert: 'すでに受け取りが完了しています'
  end

  def user_had_want_required_and_set_want
    @want = current_user.wants.find_by(id: params[:id])
    return if @want

    redirect_to wants_users_path, alert: 'ウォンツは登録されていません'
  end
end
