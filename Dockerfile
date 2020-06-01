FROM ruby:2.5.3
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       mysql-client \
                       nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn
RUN mkdir /my_portfolio
ENV APP_ROOT /app_name
WORKDIR $APP_ROOT
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock
RUN bundle install
ADD . $APP_ROOT
