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
