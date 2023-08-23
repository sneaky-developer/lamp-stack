FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    php8.1-fpm \
    php8.1-cli \
    php8.1-mbstring \
    php8.1-xml \
    php8.1-zip \
    php8.1-curl \
    nginx \
    composer \
    curl  \
    nano \
    python3
RUN apt-get -y install pip

#RUN apt-get -y install nodejs
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt update
RUN apt-get install -y nodejs

RUN sed -i 's/;clear_env = no/clear_env = no/' /etc/php/8.1/fpm/pool.d/www.conf

RUN composer create-project --prefer-dist laravel/laravel /app/laravel


#sites configurations
COPY ./nginx/nginx-site.conf /etc/nginx/sites-available/default

#creating laravel project
RUN composer create-project laravel/laravel:^9.0 example-app

#creating flask project
RUN pip3 install Flask

#creating node project
#RUN npm -y init
#RUN npm install /app/vueapp
RUN npm install -g express

#creating vue project
#RUN npm install -g @vue/cli
#build the project of vue
#npm i vue@3.2.26
#2.9.3
#RUN vue create vue-app
#
#RUN npm install
#RUN npm run-script build

RUN chmod 777 -R /var

WORKDIR /app
COPY . .

RUN chmod 777 -R /app

#making downloads in vueapp
WORKDIR /app/vueapp
RUN npm install
#RUN npm install -g @vue/cli
RUN npm install vue@3.2.26
RUN npm run build
#RUN npm install vue@3.2.26
#npm run build /app/vueapp &


EXPOSE 80 3000 8080 5000

#& npm run serve /app/vue-app 
#node /app/node/index.js
#npm install /app/vue & npm run-script build /app/vue &
CMD ["sh", "-c", "service php8.1-fpm start & python3 /app/app.py & node /app/node/index.js & nginx -g 'daemon off;'"]

#CMD service php8.1-fpm start && nginx -g "daemon off;"
