FROM node:13.3.0 AS build

WORKDIR /opt/ng

# If you have .npmrc file inside your project
# COPY .npmrc package.json package-lock.json ./
COPY package.json package-lock.json ./
RUN npm install

ENV PATH="./node_modules/.bin:$PATH" 

COPY . ./
RUN ng build --prod

FROM nginx:1.17.1-alpine
#COPY docker/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /opt/ng/dist/angular9-sample-app /usr/share/nginx/html
