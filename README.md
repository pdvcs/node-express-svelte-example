# node-express-svelte-example

A simple NodeJS + Express 'Hello World' app, with Svelte.

## Set up Project

```bash
npm install -g nodemon  # for hot-reloading
echo '{ "apiKey": "xxxx" }' > public/static/api-config.json
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

## Build

```bash
npm run bundle  # create svelte bundle
export TENOR_API_KEY=xxxx
docker build . --build-arg apikey=$TENOR_API_KEY -t pdutta/node-express-svelte-example
```

## Run

```bash
npm run server  # without docker
docker run -p 14000:3000 -d pdutta/node-express-svelte-example  # with docker
```

### Useful Docker Commands

```bash
# After build, explore the newly built container
docker run -i -t pdutta/node-express-svelte-example /bin/sh

# After run, stop and remove the container
docker ps -a  # grab the relevant CONTAINER_ID from here
docker stop CONTAINER_ID
docker rm CONTAINER_ID
```
