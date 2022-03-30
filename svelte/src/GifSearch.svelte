<script>
    var tenorKey = ""
    async function apiKey() {
        /*
            We didn't want to put an API key here, so we're loading it remotely.
            Of course the key is available client-side so it's not super-secret, but
            at least it's not in Git...

            <ProjectRoot>/public/static/config.json should be:
            { "apiKey": "TENOR_API_KEY" }
        */
        let resp = await fetch("static/api-config.json")
        if (!resp.ok) {
            throw new Error(`error fetching config: HTTP status ${resp.status}`)
        } else {
            let data = await resp.json()
            return data.apiKey
        }
    }

    async function tenorUrl(searchTerm) {
        if (tenorKey === "") {
            tenorKey = await apiKey()
            // console.log(`Tenor API key = ${tenorKey}`)
        }

        let limit = 1
        // using default locale of en_US
        return "https://g.tenor.com/v1/search?q=" + searchTerm + "&key=" + tenorKey + "&limit=" + limit
    }

    async function tenorLoader(searchTerm) {
        const resp = await fetch(await tenorUrl(searchTerm))
        if (!resp.ok) {
            const message = `error: ${resp.status}`
            throw new Error(message)
        }
        const gifs = await resp.json()
        return gifs
    }

    async function showVideo(searchTerm) {
        let gifsJson = tenorLoader(searchTerm).catch((err) => {
            throw new Error(err.message)
        })
        return gifsJson
    }

    let videoPlayed = false

    function playVideo(mp4url) {
        var video = document.getElementById("gifv")
        video.loop = true
        if (videoPlayed) {
            video.pause()
            video.removeChild(video.firstChild) // remove the `source` element
            video.load()
            videoPlayed = false
        }
        var source = document.createElement("source")

        source.setAttribute("src", mp4url)
        source.setAttribute("type", "video/mp4")
        video.appendChild(source)
        video.play()
        videoPlayed = true
    }

    function handleClick() {
        let btn = document.getElementById("gifkeyword")
        btn.disabled = true
        let promise = showVideo(btn.value)
        promise.then((resp) => {
            // document.getElementById("tx1").value = JSON.stringify(resp, null, 2);
            let gifUrl = resp.results[0].media[0].loopedmp4.url
            console.log(`*** Loading GIF from ${gifUrl} ...`)
            playVideo(gifUrl)
            btn.disabled = false
        })
    }
</script>

<label for="gifkeyword">Search Term:</label>

<input
    type="text"
    value="fireworks"
    id="gifkeyword"
    name="gifkeyword"
    required
    minlength="3"
    maxlength="16"
    size="20"
/>
<button on:click={handleClick}>Fetch GIF!</button>
<br /><br />
<!-- <textarea id="tx1" /><br /><br /> -->

<!-- svelte-ignore a11y-media-has-caption -->
<video id="gifv" width="400" height="300" />

<style>
    video {
        display: block;
        border: 2px solid navy;
    }
    /* textarea {
        display: block;
        width: 50%;
        height: 600px;
        font-family: "Cascadia Code", Connsolas, "Courier New", Courier, monospace;
        font-size: 18px;
    } */
</style>
