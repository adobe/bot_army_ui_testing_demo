# Bot Army UI Testing Demo

Can bots use a browser? Yes they can. This is a demo of the bots browsing the Bot
Army Cookbook to "learn" how do UI testing.

See [Bot Army Docs](https://hexdocs.pm/bot_army/1.0.0/readme.html) on how to use the
bot army.

The [Bot Army Cookbook](https://opensource.adobe.com/bot_army_cookbook/) is also
useful.

## Set up

### 1. Elixir/Erlang and Elixir deps

You will need to have Elixir and Erlang installed on your computer/container
([asdf](https://github.com/asdf-vm/asdf-elixir) works well for this).

Then fetch and compile deps with `mix do deps.get, deps.compile`.

### 2. Browser integration tools

This project uses [Hound](https://hexdocs.pm/hound/readme.html), as the browser
automation library. It in turn relies on having some kind of web driver.

There are a few to choose from (selenium, chromedriver, phantomjs for instance).
phantomjs or headless chrome with chrome driver is useful if you want a headless
browser, but if you want to see the what the bot(s) are doing,
[chromedriver](https://chromedriver.chromium.org/) works well: `brew cask install chromedriver` or download it from the homepage.

## Running

You need to run the webdriver first (in the background or a separate window):
`chromedriver`. Make sure you are configured to use the driver you selected, see
`config/config.exs`.

You can run the bots with `mix test`.
