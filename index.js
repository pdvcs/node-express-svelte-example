var path = require("path")
const express = require("express")
const app = express()
const port = 3000

app.use(express.static(path.join(__dirname, "public")))
app.get("/hello", function (req, res) {
    res.send(`Hello World, it's ${new Date().toISOString()}!`)
})

app.listen(port, function () {
    console.log(`Example app listening on port ${port}!`)
})
