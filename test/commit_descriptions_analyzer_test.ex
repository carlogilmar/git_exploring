defmodule CommitDescriptionsAnalizerTest do
  use ExUnit.Case
  alias GitExploring.CommitDescriptionsAnalizer

  test "Analyze a commit description" do
    commit = {"aed0dbf7963a37aab277e083c22b616863f04773", "carlogilmar12@gmail.com", "Thu Jan 31 10:20:09 2019 -0600", "#60 Removing get_initials from patient and responsible"}
    words = CommitDescriptionsAnalizer.get_words_from_description( commit )
    assert words == ["#60", "removing", "get_initials", "from", "patient", "and", "responsible"]
  end

  test "Get all the words by a list of commits" do
    c = {"", "", "", "#60 Removing get_initials from patient and responsible"}
    commits = [c,c,c,c]
    words_list = CommitDescriptionsAnalizer.get_words_from_commits( commits )
    assert length(words_list) == 28
  end

end
