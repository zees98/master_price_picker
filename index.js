const express = require("express");
const puppeteer = require("puppeteer");

const PORT = process.env.PORT || 5000;

const app = express();

app.get("/", (req, res) => {
  res.send(
    `
    <html>
    <body>
        <h1>API ROUTES</h1>
        <ul>
            <li>/daraz</li>
            <li>/olx</li>
        </ul>
    </body>
    <html>
    `
  );
});
app.get("/daraz", (req, res) => {
  console.log(req.query);
  (async () => {
    let url = `https://www.daraz.pk/catalog/?q=${req.query.q}`;
    const browser = await puppeteer.launch();
    const page = await browser.newPage();
    await page.goto(url, { waitUntil: "networkidle2" });
    const result = await page.evaluate(() => {
      const products = document.querySelectorAll(".c2prKC");
      const data = [];
      products.forEach((product) => {
        const title = product.querySelector(".c16H9d").innerText;
        const price = product.querySelector(".c13VH6").innerText;
        const image = product.querySelector("img.c1ZEkM")?.src;
        console.log(image);
        data.push({ title, price, image });
      });
      return data;
    });
    res.json({
      source: "daraz",
      query: req.query.q,
      time: new Date().toUTCString(),
      dataCount: result.length,
      data: result,
    });
  })();
});

app.get("/olx", (req, res) => {
  res.json({ source: "olx" });
});

app.listen(PORT, () => {
  console.log(`Server started on port ${PORT}`);
});
