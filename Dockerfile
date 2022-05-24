FROM ruby:3.0.4

# yarnパッケージ管理ツールをインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn

# 必要なパッケージインストール
# magemagick -> CarrierWaveで使用
RUN apt-get update -qq && apt-get install -y nodejs yarn default-mysql-client imagemagick
WORKDIR /bean_stamp
COPY Gemfile /bean_stamp/Gemfile
COPY Gemfile.lock /bean_stamp/Gemfile.lock
RUN bundle install
COPY . /bean_stamp

RUN yarn install --check-files
RUN bundle exec rails webpacker:compile

# コンテナ起動時に実行させるスクリプトを追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Rails サーバ起動
CMD ["rails", "server", "-b", "0.0.0.0"]
