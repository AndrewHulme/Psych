FROM phusion/passenger-customizable:1.0.11
LABEL maintainer="github.com/ethaning"

ENV HOME /root

ARG RAILS_ENV
ENV RAILS_ENV ${RAILS_ENV:-development}

RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default

RUN curl -L https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update -qq \
    && apt-get install -y ca-certificates build-essential libpq-dev nodejs sudo tzdata imagemagick \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /home/app/web
WORKDIR /home/app/web

COPY docker/install-* /home/app/web/docker/
RUN bash docker/install-ruby.sh

RUN usermod -u 1000 -G staff,sudo app

ADD docker/nginx/env.conf /etc/nginx/main.d/env.conf
ADD docker/nginx/sites-enabled/web.conf /etc/nginx/sites-enabled/web.conf

ADD . /home/app/web
ENV PATH /home/app/web/bin:$PATH

RUN bash docker/install-gems.sh

RUN chown -R app:app /home/app/web

# Init scripts
RUN mkdir -p /etc/my_init.d
ADD docker/init/* /etc/my_init.d/
RUN chmod +x /etc/my_init.d/*

CMD ["/sbin/my_init"]
