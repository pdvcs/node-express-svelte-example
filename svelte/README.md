# Svelte components for this project

This folder has [Svelte](https://svelte.dev) components for a larger project.

📘 [Further information](https://dtang.dev/2020-01-22-adding-svelte-3-to-an-existing-application/).

To install dev dependencies, type `npm install` in this folder.

To build the components, type `npm run build` in this directory, or `npm run bundle` in the *parent* directory. This will deliver bundles to `../public/build/svelte-bundle.{js,css}`. Adjust `rollup.config.js` if you need to tweak this.

To create new component folders like this, type `npx degit sveltejs/template <FOLDER_NAME>`.
