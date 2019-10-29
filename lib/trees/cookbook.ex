defmodule BotArmyStarter.Trees.Cookbook do
  @moduledoc """
  Tests out the bot army cookbook content.
  """

  import BotArmy.Actions, only: [action: 2, action: 3]
  alias BotArmy.Actions, as: Common
  alias BehaviorTree.Node
  alias BotArmyStarter.Actions.Cookbook

  use BotArmy.IntegrationTest.Workflow

  parallel "test" do
    url = "https://git.corp.adobe.com/pages/manticore/bot_army_cookbook/"
    title = "Bot Army Cookbook - Recipes for building your bots"
    auth_title = "Adobe Inc - Extra Verification"

    Node.sequence([
      action(Cookbook, :visit, [url]),
      # The cookbook is hosted on Adobe Corp Github, which requires authentication,
      # so check for that first
      Node.select([
        Node.sequence([
          action(Cookbook, :validate_title, [auth_title]),
          action(Cookbook, :authenticate),
          action(Cookbook, :validate_title, [title])
        ]),
        action(Cookbook, :validate_title, [title])
      ]),
      action(Cookbook, :search, ["browser"]),
      action(Cookbook, :validate_search_results, [["Do browser UI testing"]]),
      action(Common, :wait, [1]),
      action(Cookbook, :click_link, ["Do browser UI testing"]),
      action(Cookbook, :validate_title, ["Bot Army Cookbook - Do browser UI testing"]),
      action(Common, :wait, [1]),
      action(Cookbook, :peek_behind_the_curtain),
      action(Common, :log, ["Whoa....!"]),
      action(Common, :wait, [1])
    ])
  end
end
