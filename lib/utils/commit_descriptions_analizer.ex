defmodule GitExploring.CommitDescriptionsAnalizer do

  def get_words_from_description( { _hash, _author, _date, description} ) do
    words = description |> String.split(" ")
    for w <- words, do: String.downcase( w )
  end

end
