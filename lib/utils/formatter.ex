defmodule GitExploring.Formatter do

  def parse_commits_from_log( output ) do
    output_parsed = "\n\n" <> output |> String.split("\n\ncommit")
    [_ | commits_descriptions] = output_parsed
    commits_descriptions
  end

  def parse_commit_references( commit ) do
    [hash, author, date, _empty, description] = commit |> String.split("\n")
    [_, author_email, _] = author |> String.split(["<", ">"])
    [_, commit_date] = date |> String.split("   ")
    { String.trim(hash), author_email, commit_date, String.trim(description) }
  end
end
