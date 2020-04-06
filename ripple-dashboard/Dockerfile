FROM node:10

RUN apt-get -yqq install git
RUN git clone --single-branch --branch lb --depth=1 https://github.com/lendingblock/rippled-ws-client-dashboard.git /app
WORKDIR /app
COPY .env.local /app
RUN npm install && npm run build

FROM nginx
RUN mkdir /app
COPY --from=0 /app/dist /app
COPY entrypoint.sh /app/entrypoint.sh
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 10080
CMD [ "/app/entrypoint.sh" ]