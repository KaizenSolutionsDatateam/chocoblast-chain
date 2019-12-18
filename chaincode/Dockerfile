FROM node:8.9

WORKDIR /app

COPY . .

ENV PATH /app/node_modules/.bin:$PATH

RUN yarn

CMD tail -f /dev/null
