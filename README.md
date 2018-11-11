# chrome-screenshot

Script for making screenshots of webpages. It uses
google chrome/chromium in headless mode.

# Features

* Creates *.png file with screenshot of the whole page. This is most
  accurate screenshot - it captures exactly what you see in your browser.
  It simulates a monitor with unlimited height -
  this way the entire page is captured.

* Additionally, it creates pdf file of the same page. It is not as
  accurate as png screenshot, but it is convenient beceause it is searchable
  (unlike png file)

* It does not install anything on your machine - everything is built in
  the local directory.

# Requirements

* `make` (Makefile is used to download `node` and dependencies to local directory)
* Tested only on Linux (Ubuntu 16.04)
* Google Chrome / Chromium (tested on version 72.0)

# Prerequisites

* It uses `google-chrome` command. If you want to use specific
  command to run chrome/chromium, set `CHROME_PATH` variable in file
  `config.sh` (create it from file `config.dist.sh`)

* It uses chrome profile from directory `"${HOME}/.config/chromium"`
  If you want change that, modify variable  `userDir` in file `screenshot.sh`
  Using existing user profile (instead of new profile) is convenient,
  because you will see the page exactly as you see it in your browser -
  for exemple you will be logged in, you will not see any
  popups/banners that new user would see.

# How to use it

Run command:

```bash
./screenshot.sh --url <url>
```

You can run this command from any directory. It will save 2 files in your
current directory: `screenshot.png` and `screenshot.pdf`





