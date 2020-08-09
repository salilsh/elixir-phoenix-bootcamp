defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "Deck should contain six cards" do
    deck_size = length(Cards.create_deck)
    assert deck_size == 6
  end
end
