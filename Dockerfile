FROM node:18

RUN npm config set registry https://registry.npm.taobao.org
WORKDIR /songtang/daohe
COPY ./ /songtang/daohe
# RUN npm install && npm run build
RUN yarn install && yarn build

FROM nginx:alpine
RUN mkdir -p /songtang/daohe
COPY --from=0 /songtang/daohe/dist /songtang/daohe
# COPY --from=0 /songtang/daohe/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
