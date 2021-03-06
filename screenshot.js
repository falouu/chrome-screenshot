const puppeteer = require('puppeteer-core');
const argv = require('minimist')(process.argv.slice(2));
const url = argv.url;
const chromePath = argv.chromePath;
const outputDir = argv.outputDir || ".";
const userDir = argv.userDir;

if (!url) {
    throw Error("--url paremeter not set")
}
if (!chromePath) {
    throw Error("--chromePath parameter not set")
}
if (!userDir) {
    throw Error("--userDir parameter not set")
}

(async () => {
    const browser = await puppeteer.launch({
        executablePath: chromePath,
        userDataDir: userDir,
        //headless: false //TODO: delete
    });
    const page = await browser.newPage();
    await page.goto(url);
    await page.setViewport({
        width: 1600,
        height: 600
    });
    await page.setViewport({
        width: 1600,
        height: await page.evaluate(() => document.body.clientHeight)
    });
    //Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, 100000); //TODO: delete
    await page.screenshot({path: outputDir + '/screenshot.png'});
    await page.pdf({path: outputDir + '/screenshot.pdf', format: 'A2'});

    await browser.close();
})();