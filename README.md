# node-express-svelte-example

A simple NodeJS + Express 'Hello World' app, with Svelte.

## Set up Project

```bash
npm install -g nodemon # for hot-reloading
echo '{ "apiKey": "TENOR_API_KEY" }' > public/static/api-config.json
```

## Develop with hot reloading

```bash
{ pushd svelte && npm run dev; } & { ROLLUP_PID=$!;  echo "Svelte rollup launched in -w mode, type \"pkill -P $ROLLUP_PID\" to kill."; npm run live; }
```
Or, interactively:

```bash
projectroot/svelte$ npm run dev
projectroot$ npm run live
```

## Deploy and Run

```bash
npm run bundle # create svelte bundle
npm run server
```

## Docker

The application has now been dockerized. You can use the following commands to build and run the container:

```bash
# Build
docker build . --build-arg apikey=$TENOR_API_KEY -t pdutta/node-express-svelte-example

# Explore the newly built container
docker run -i -t pdutta/node-express-svelte-example /bin/sh

# Run -- visit http://localhost:14000 to view the site
docker run -p 14000:3000 -d pdutta/node-express-svelte-example

# Stop/Remove the container
docker ps -a # grab the relevant CONTAINER_ID from here
docker stop CONTAINER_ID
docker rm CONTAINER_ID
```
