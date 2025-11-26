FROM node:18 as BUILDER

WORKDIR /app

COPY app/ .

RUN npm install --production


FROM node:18-alpine as RUNTIME

WORKDIR /app

COPY --from=builder /app /app

EXPOSE 3000

ENTRYPOINT ["node" , "server.js"]
