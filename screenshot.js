const puppeteer = require('puppeteer-core');
const argv = require('minimist')(process.argv.slice(2));
const url = argv.url;

if (!url) {
    throw Error("--url paremeter not set")
}

(async () => {
    const browser = await puppeteer.launch(chromePath);
    const page = await browser.newPage();
    await page.goto(url);
    await page.screenshot({path: 'screenshot.png'});

    await browser.close();
})();