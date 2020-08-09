defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling documentation.
  """
  def create_deck do
    values = ["Ace", "Two", "Three"]
    suits = ["hearts", "spades"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end

  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    The `has` method checks whether a deck contains a card or not. It takes two parameters: first is the deck, and the second is the card. 
    The method will check if the card exists in the deck or not. 
  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.has?(deck, "Two of hearts")
      true

  """  
  def has?(deck, card) do
    Enum.member?(deck, card) 
  end

  @doc """
   this method takes a deck and a `hand_size` and returns a hand. 

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, rest} = Cards.deal(deck, 3)
      iex> hand
      ["Ace of hearts", "Two of hearts", "Three of hearts"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

  def save(deck, file) do 
    binary = :erlang.term_to_binary(deck)
    File.write(file, binary)
  end

  def load(file) do 
    case File.read(file) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "Error: File '#{file}' does not exist."
    end
    
  end

end
