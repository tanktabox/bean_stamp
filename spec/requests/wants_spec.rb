require 'rails_helper'

RSpec.describe 'Wants', type: :request do
  let(:base_title) { ' | BeansApp' }
  let(:user) { create(:user) }
  let!(:roaster) { create(:roaster) }
  let!(:bean) { create(:bean, :with_image, :with_3_taste_tags, roaster: roaster) }
  let!(:offer) { create(:offer, bean: bean) }

  describe 'GET #index' do
    subject { get offer_wants_path(offer) }
    context 'when a user is not signed in' do
      it 'redirects to new_user_session_path ' do
        subject
        expect(response).to redirect_to new_user_session_path
      end
    end
    context 'when a user is not belonging to a roaster' do
      before { sign_in user }
      it 'redirects to root_path ' do
        subject
        expect(response).to redirect_to root_path
      end
    end
    context 'when a user does not have the offer' do
      let(:another_user) { create(:user, roaster: another_roaster) }
      let(:another_roaster) { create(:roaster) }
      before { sign_in another_user }
      it 'redirects to beans_path ' do
        subject
        expect(response).to redirect_to beans_path
      end
    end
    context 'when a user is belonging to a roaster with the offer' do
      let(:user_with_a_offer) { create(:user, roaster: roaster) }
      before { sign_in user_with_a_offer }
      it 'gets offers/index with no offers' do
        subject
        expect(response).to have_http_status(:success)
        expect(response.body).to include("<title>ウォンツしたユーザー#{base_title}</title>")
      end
    end
  end

  describe 'POST #create' do
    subject { proc { post offer_wants_path(offer) } }
    context 'when user is not signed in' do
      it 'redirects to new_user_session_path ' do
        subject.call
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'when user is signed in' do
      before { sign_in user }
      it { is_expected.to change(Want, :count).by(1) }
      it {
        is_expected.to change(user.wants, :count).by(1)
      }
      it { is_expected.to change(offer.wants, :count).by(1) }
      context 'with Ajax' do
        subject { proc { post offer_wants_path(offer), xhr: true } }
        it { is_expected.to change(Want, :count).by(1) }
      end
    end
  end

  describe 'DELET #destroy' do
    let(:want) { user.wants.find_by(offer_id: offer.id) }
    subject { proc { delete offer_want_path(offer, want) } }
    before do
      user.wanting_offers << offer
    end
    context 'when user is not signed in' do
      it 'redirects to new_user_session_path ' do
        subject.call
        expect(response).to redirect_to new_user_session_path
      end
    end
    context 'when user is signed in' do
      before { sign_in user }
      it { is_expected.to change(Want, :count).by(-1) }
      it { is_expected.to change(user.wants, :count).by(-1) }
      it { is_expected.to change(offer.wants, :count).by(-1) }
      context 'with Ajax' do
        subject { proc { delete offer_want_path(offer, want), xhr: true } }
        it { is_expected.to change(Want, :count).by(-1) }
      end
    end
  end
end
