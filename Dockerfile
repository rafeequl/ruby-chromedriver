# Base image:
FROM ruby:2.5.0

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev mysql-client apt-transport-https ca-certificates unzip xvfb

# Install nodejs and yarn
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs
RUN npm install --global yarn

# Install bundler
RUN gem install bundler --no-ri --no-rdoc

# Install chromedirver
ENV CHROMEDRIVER_VERSION=2.36 
RUN mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION
RUN curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip 
RUN unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION 
RUN rm /tmp/chromedriver_linux64.zip 
RUN chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver 
RUN ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver

# INSTALL CHROME
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list 
RUN apt-get -yqq update 
RUN apt-get -yqq install google-chrome-stable 
RUN rm -rf /var/lib/apt/lists/*

