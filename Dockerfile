FROM node:11.14
MAINTAINER arvind viswanathan<arvindviswanathan1@gmail.com>
COPY . .
RUN npm install
EXPOSE 8000

CMD [ "npm", "start"]

