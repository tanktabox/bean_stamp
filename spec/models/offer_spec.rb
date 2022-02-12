require 'rails_helper'

RSpec.describe Offer, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:bean) }
    it { is_expected.to have_many(:wants) }
    it { is_expected.to have_many(:wanted_users).through(:wants) }
    it { is_expected.to have_one(:roaster).through(:bean) }
    pending { is_expected.to have_many(:likes) }
    pending { is_expected.to have_many(:comments) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :bean_id }
    it { is_expected.to validate_presence_of :ended_at }
    it { is_expected.to validate_presence_of :roasted_at }
    it { is_expected.to validate_presence_of :receipt_started_at }
    it { is_expected.to validate_presence_of :receipt_ended_at }
    it { is_expected.to validate_presence_of :price }
    it { is_expected.to validate_numericality_of(:price).only_integer }
    it { is_expected.to validate_presence_of :weight }
    it { is_expected.to validate_numericality_of(:weight).only_integer }
    it { is_expected.to validate_presence_of :amount }
    it { is_expected.to validate_numericality_of(:amount).only_integer }
  end

  describe '#update_status' do
    before { test_offer.update_status }
    let!(:bean) { create(:bean, :with_image, :with_3_taste_tags) }
    let(:offer) { create(:offer, bean: bean) }
    let(:roasting_offer) { create(:offer, :on_roasting, bean: bean) }
    let(:preparing_offer) { create(:offer, :on_preparing, bean: bean) }
    let(:selling_offer) { create(:offer, :on_selling, bean: bean) }
    let(:sold_offer) { create(:offer, :end_of_sales, bean: bean) }

    context 'when an offer is on offer' do
      let(:test_offer) { offer }
      it { expect(test_offer.status).to eq 'on_offering' }
    end
    context 'when an offer is on roasting' do
      let(:test_offer) { roasting_offer }
      it { expect(test_offer.status).to eq 'on_roasting' }
    end
    context 'when an offer is on preparing' do
      let(:test_offer) { preparing_offer }
      it { expect(test_offer.status).to eq 'on_preparing' }
    end
    context 'when an offer is on selling' do
      let(:test_offer) { selling_offer }
      it { expect(test_offer.status).to eq 'on_selling' }
    end
    context 'when an offer is end of sales' do
      let(:test_offer) { sold_offer }
      it { expect(test_offer.status).to eq 'end_of_sales' }
    end
  end
end
