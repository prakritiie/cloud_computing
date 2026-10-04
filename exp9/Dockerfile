FROM node:18-bullseye

WORKDIR /app

# Intentionally insecure: hardcoded credentials
ENV AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"
ENV AWS_SECRET_ACCESS_KEY="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 80

# Intentionally insecure: container runs as root
CMD ["node", "index.js"]