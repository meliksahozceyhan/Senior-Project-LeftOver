FROM node:12.13-alpine

RUN mkdir ~/app

COPY ./dist/ ~/app/

EXPOSE 3000
EXPOSE 3001

CMD ["node", "dist/main"]