FROM ruby:3.1

# yarnパッケージ管理ツールをインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget sqlite3 && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

RUN apt-get update -qq && apt-get install -y nodejs yarn
# RUN apt-get install -y npm
# RUN yarn add react react-dom prop-types 
RUN mkdir /myapp
WORKDIR /myapp
COPY ./Gemfile /myapp/Gemfile
# COPY ../Gemfile.lock /myapp/Gemfile.lock
RUN gem install solargraph
RUN bundle install
COPY ./ /myapp

RUN yarn install
# RUN yarn add --dev eslint eslint-config-airbnb

# RUN yarn install --check-files
# RUN bundle exec rails webpacker:compile

# コンテナ起動時に実行させるスクリプトを追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
# 
# Rails サーバ起動
# CMD ["rails", "server", "-b", "0.0.0.0"]
# CMD ["./bin/dev"]
CMD ["/bin/bash"]

# hogehoge
# hoge
