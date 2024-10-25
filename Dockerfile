FROM node as build

WORKDIR /react-app

COPY package*.json ./

RUN yarn install

COPY . .

RUN yarn run build


FROM nginx 

#copy my custom nginx config file to default nginx image
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf

#copy already created react-app from build image to nginx html folder
COPY --from=build /react-app/build /usr/share/nginx/html