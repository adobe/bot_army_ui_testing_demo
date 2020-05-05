defmodule BotArmyStarter.Actions.Cookbook do
  @moduledoc """
  Tests out the bot army cookbook content.
  """

  alias Hound.Helpers.{Session, Navigation, Page, Element}

  require Logger

  def visit(_context, url) when is_binary(url) do
    Session.start_session()

    Navigation.navigate_to(url)
    :succeed
  end

  @doc """
  Checks the page title against the provided expectation.

  This has built-in retry logic in case the page takes a long time to load or
  redirect.
  """
  def validate_title(context, expected_title) do
    actual = Page.page_title()

    if actual == expected_title do
      :succeed
    else
      Logger.debug(actual)
      retry_with_timeout(context)
    end
  end

  @doc """
  Finds the main search input and types the supplied text.

  Crashes if unable to find the element.
  """
  def search(_context, term) do
    Page.find_element(:id, "search_input")
    |> Element.fill_field(term)

    # wait for search to process (doesn't seem to work without this for some reason)
    Process.sleep(1000)
    :succeed
  end

  @doc """
  Checks the search results against the supplied list.

  Crashes if unable to find any elements.
  """
  def validate_search_results(_context, expected_results) do
    actual =
      Page.find_element(:id, "search_results")
      |> Page.find_all_within_element(:tag, "a")
      |> Enum.map(&Element.visible_text/1)

    if actual == expected_results do
      :succeed
    else
      Logger.error("Expected #{inspect(expected_results)}\nActual#{inspect(actual)}")
      :fail
    end
  end

  @doc """
  Clicks the link with the supplied text.

  Crashes if unable to find the element.
  """
  def click_link(_context, link_text) do
    Page.find_element(:link_text, link_text)
    |> Element.click()

    :succeed
  end

  @doc """
  Just for fun.
  """
  def peek_behind_the_curtain(_context) do
    Element.click({:link_text, "UI testing demo"})
    Process.sleep(1500)
    Element.click({:link_text, "test"})
    Process.sleep(1500)
    Element.click({:link_text, "bot_army_starter_test.exs"})
    Process.sleep(1500)

    if Page.visible_page_text() =~ ~S(test_tree "Learn how to do UI testing", context do),
      do: :succeed,
      else: :fail
  end

  @doc """
  Helper function to retry which manages timout values transparently.

  Options can include:

  * `timeout` - how long before failing, default 5000
  * `wait` - how long to wait before retrying, default 500

  This will either `:continue` or `:fail`, so call this from another action's
  unsuccessful clause instead of `:fail`ing immediately.
  """
  def retry_with_timeout(context, opts \\ []) do
    timeout = Keyword.get(opts, :timeout, 2000)
    wait = Keyword.get(opts, :wait, 300)
    time_passed = Map.get(context, :time_passed, 0)

    if time_passed <= timeout do
      Process.sleep(wait)
      {:continue, time_passed: time_passed + wait}
    else
      {:fail, time_passed: 0}
    end
  end
end
