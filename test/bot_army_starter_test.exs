defmodule BotArmyStarterTest do
  @moduledoc false

  # See https://hexdocs.pm/bot_army/1.0.0/BotArmy.IntegrationTest.html
  use BotArmy.IntegrationTest, async: true

  alias BotArmyStarter.Actions.Cookbook

  @tag :verbose
  test_tree "Learn how to do UI testing", context do
    Node.sequence([
      action(Cookbook, :visit, [
        "https://opensource.adobe.com/bot_army_cookbook/"
      ]),
      action(Cookbook, :validate_title, ["Bot Army Cookbook - Recipes for building your bots"]),
      action(BotArmy.Actions, :wait, [1]),
      action(Cookbook, :search, ["browser"]),
      action(Cookbook, :validate_search_results, [["Do browser UI testing", "Do mobile application UI testing"]]),
      action(BotArmy.Actions, :wait, [1]),
      action(Cookbook, :click_link, ["Do browser UI testing"]),
      action(Cookbook, :validate_title, ["Bot Army Cookbook - Do browser UI testing"]),
      action(BotArmy.Actions, :wait, [1]),
      action(Cookbook, :peek_behind_the_curtain),
      action(BotArmy.Actions, :log, ["Whoa....!"]),
      action(BotArmy.Actions, :wait, [3])
    ])
  end
end
