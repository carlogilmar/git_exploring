defmodule GitExploring.CommitDescriptionsAnalyzer do

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
    words_for_find = words |> Enum.uniq()
    counters =
      for w <- words_for_find do
        counter = Enum.count( words, fn(word) -> word == w end)
        {w, counter}
      end
    Enum.sort_by( counters, fn {_word, counter} -> counter end)
  end

end