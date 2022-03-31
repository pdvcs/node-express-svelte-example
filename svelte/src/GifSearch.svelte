<script>
    let tenorKey = ""
    let videoPlayed = false

    function errorHandler(err) {
        return new Response(
            JSON.stringify({
                msgtype: "error",
                message: err.message,
            })
        )
    }
    function ensureSuccess(resp) {
        if (!resp.ok) {
            throw Error(`error fetching ${resp.url}: HTTP status ${resp.status}, ${resp.statusText}`)
        }
        return resp
    }

    async function apiKey() {
        /*
            We didn't want to put an API key here, so we're loading it remotely.
            Of course the key is available client-side so it's not super-secret, but
            at least it's not in Git...

            <ProjectRoot>/public/static/api-config.json should be:
            { "apiKey": "TENOR_API_KEY" }
        */
        let data = await (await fetch("static/api-config.json").then(ensureSuccess).catch(errorHandler))
            .json()
            .catch(errorHandler)
        if ("apiKey" in data === false) {
            throw Error("error fetching API key")
        } else {
            return data.apiKey
        }
    }

    async function tenorUrl(searchTerm) {
        if (tenorKey === "") {
            tenorKey = await apiKey()
            // console.log(`API key = ${tenorKey}`)
        }

        let limit = 1
        // using default locale of en_US
        return "https://g.tenor.com/v1/search?q=" + searchTerm + "&key=" + tenorKey + "&limit=" + limit
    }

    async function fetchGif(searchTerm) {
        const resp = await fetch(await tenorUrl(searchTerm))
            .then(ensureSuccess)
            .catch(errorHandler)
        const gifs = await resp.json()
        return gifs
    }

    function playVideo(mp4url) {
        let video = document.getElementById("gifv")
        video.loop = true
        if (videoPlayed) {
            video.pause()
            video.removeChild(video.firstChild) // remove the `source` element
            video.load()
            videoPlayed = false
        }
        let source = document.createElement("source")

        source.setAttribute("src", mp4url)
        source.setAttribute("type", "video/mp4")
        video.appendChild(source)
        video.play()
        videoPlayed = true
    }

    function onPressFetchButton() {
        let txtKeyword = document.getElementById("keyword")
        let btnFetch = document.getElementById("btnfetch")
        btnFetch.disabled = true
        let promise = fetchGif(txtKeyword.value)
        promise
            .then((resp) => {
                if (resp.msgtype === "error") {
                    console.log("Problem loading GIF:", resp)
                } else {
                    let gifUrl = resp.results[0].media[0].loopedmp4.url
                    if (typeof gifUrl !== "undefined") {
                        console.log(`*** loading ${gifUrl} ...`)
                        playVideo(gifUrl)
                    } else {
                        console.log("warning: gifUrl is undefined, resp was:", resp)
                    }
                }
                btnFetch.disabled = false
            })
            .catch((err) => {
                console.log("Error loading GIF:", err)
            })
    }
</script>

<label for="keyword">Search Term:</label>

<input type="text" value="fireworks" id="keyword" name="keyword" required minlength="3" maxlength="16" size="20" />
<button id="btnfetch" on:click={onPressFetchButton}>Fetch GIF!</button>
<br /><br />

<!-- svelte-ignore a11y-media-has-caption -->
<video id="gifv" width="400" height="300" />

<style>
    video {
        display: block;
        border: 1px solid navy;
    }
</style>
