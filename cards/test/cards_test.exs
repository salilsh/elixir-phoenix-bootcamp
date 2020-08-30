defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "Deck should contain six cards" do
    deck_size = length(Cards.create_deck)
    assert deck_size == 6
  end

  test "Shuffled deck should not match the original deck" do
    shuffled_deck = Cards.shuffle Cards.create_deck
    refute shuffled_deck == Cards.create_deck
  end

end
