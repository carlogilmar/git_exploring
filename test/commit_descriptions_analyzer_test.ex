defmodule CommitDescriptionsAnalyzerTest do
  use ExUnit.Case
  alias GitExploring.CommitDescriptionsAnalyzer

  test "Analyze a commit description" do
    commit = {"aed0dbf7963a37aab277e083c22b616863f04773", "carlogilmar12@gmail.com", "Thu Jan 31 10:20:09 2019 -0600", "#60 Removing get_initials from patient and responsible"}
    words = CommitDescriptionsAnalyzer.get_words_from_description( commit )
    assert words == ["#60", "removing", "get_initials", "from", "patient", "and", "responsible"]
  end

  test "Get all the words by a list of commits" do
    c = {"", "", "", "#60 Removing get_initials from patient and responsible"}
    commits = [c,c,c,c]
    words_list = CommitDescriptionsAnalyzer.get_words_from_commits( commits )
    assert length(words_list) == 28
  end

  test "Count the times that a word appear" do
    words = ["word1", "word2", "word3", "word2", "word3", "word1", "word2"]
    words_counters = CommitDescriptionsAnalyzer.get_words_counters( words )
    words_countes_expected = [ {"word1", 2},  {"word3", 2},  {"word2", 3} ]
    assert words_counters == words_countes_expected
  end

end
