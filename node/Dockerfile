# Use an official Node.js runtime as the base image
FROM node

RUN apt-get update && apt-get install -y nginx npm nano

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
#RUN npm install

# Copy the rest of the application code
COPY . .

#add enviornment
ENV MONGO_URI=${MONGO_URI}

# Expose the port your application uses
EXPOSE 3000

# Start the application
CMD ["node", "index.js"]