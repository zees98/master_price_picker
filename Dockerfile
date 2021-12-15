FROM node:alpine

WORKDIR /src/app/spp/

COPY package.json .

RUN npm install

COPY index.js .

CMD node index.js