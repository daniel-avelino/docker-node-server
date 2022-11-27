FROM public.ecr.aws/docker/library/node:lts-slim
RUN apt-get update && apt-get install git -y

WORKDIR /ecs-app

COPY package*.json ./
COPY controller controller
COPY server.js server.js

RUN npm install
RUN chown -R node:node /ecs-app
RUN sudo apt-get install libcap2-bin
RUN sudo setcap cap_net_bind_service=+ep /usr/local/bin/node

ENV NODE_ENV=production
ENV ENV_ECS=true
USER sudo
EXPOSE 8000

ENTRYPOINT ["npm", "start"]
