FROM node:16-alpine

ARG apikey
ENV api_key=$apikey

WORKDIR /workdir

# Copy everything, except for the files/folders in .dockerignore
# This includes the `svelte` directory, as wo won't need it in production,
# as we'll already rollup the resources.
COPY . .

# set up API key
RUN echo "{ \"apiKey\": \"$api_key\" }" > public/static/api-config.json
# instead of `npm install`...
RUN npm ci --only=production

EXPOSE 3000
CMD [ "node", "index.js" ]
