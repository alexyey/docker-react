#Tag node image for the builder phase
FROM node:alpine AS builder

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .

RUN npm run build

#Recovering image for the serving phase
FROM nginx
#Specify port exposure for a port in AWS (not usefull locally)
EXPOSE 80

#Recovering build folder from the bulder phase
COPY --from=builder /app/build /usr/share/nginx/html

#The nginx image will automatically star the server
