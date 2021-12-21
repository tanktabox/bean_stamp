FactoryBot.define do
  factory :bean do
    name { 'テストビーン' }
    country { 'エチオピア' }
    subregion { 'イルガチェフェ' }
    farm { 'テストファーム' }
    variety { 'アビシニカ' }
    elevation { '1500' }
    process { 'ナチュラル' }
    describe { 'テストコーヒー豆です' }
    cropped_at { '2021-01-01' }
    acidity { '3' }
    flavor { '3' }
    body { '3' }
    bitterness { '3' }
    sweetness { '3' }
    roaster
    roast_level { MstRoastLevel.find(3) }

    after(:build) do |bean|
      bean.bean_images << build(:bean_image, bean: bean)
      bean.taste_tags << MstTasteTag.find(1)
      bean.taste_tags << MstTasteTag.find(2)
      bean.taste_tags << MstTasteTag.find(3)
    end
  end

  factory :bean_image do
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/sample.jpg'), 'image/jpg') }
  end
end
