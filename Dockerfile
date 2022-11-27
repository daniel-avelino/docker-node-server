FROM public.ecr.aws/docker/library/node:lts-slim
RUN apt-get update && apt-get install git -y

WORKDIR /ecs-app

COPY package*.json ./
COPY controller controller
COPY server.js server.js

RUN npm install
RUN chown -R node:node /ecs-app

ENV NODE_ENV=production
ENV ENV_ECS=true
USER node
EXPOSE 3000

ENTRYPOINT ["npm", "start"]
