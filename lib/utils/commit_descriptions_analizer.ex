defmodule GitExploring.CommitDescriptionsAnalizer do

  def get_words_from_description( { _hash, _author, _date, description} ) do
    words = description |> String.split(" ")
    for w <- words, do: String.downcase( w )
  end

  def get_words_from_commits( commits ) do
    words_list = for c <- commits, do: get_words_from_description( c )
    words_list |> List.flatten()
  end

end
