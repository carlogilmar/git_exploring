defmodule GitExploring.CommitDescriptionsAnalyzer do

  @doc" ## Main function ##"
  def analyzer_commits_words( commits ) do
    commits
      |> get_words_from_commits()
      |> get_words_counters()
  end

  def get_words_from_commits( commits ) do
    words_list = for c <- commits, do: get_words_from_description( c )
    words_list |> List.flatten()
  end

  def get_words_from_description( { _hash, _author, _date, description} ) do
    words = description |> String.split(" ")
    for w <- words, do: String.downcase( w )
  end

  def get_words_counters( words ) do
    words
      |> Enum.uniq()
      |> get_counters(words)
      |> Enum.sort_by( fn {_word, counter} -> counter end)
      |> Enum.reverse()
      |> get_most_recurrent_words()
  end

  def get_counters( words_for_find, words ) do
    for w <- words_for_find do
      counter = Enum.count( words, fn(word) -> word == w end)
      {w, counter}
    end
  end

  def get_most_recurrent_words( counters ) do
    size = length(counters)
    case size do
      size when size < 25 -> counters
      _ -> Enum.slice( counters, 0, 25)
    end
  end

end
