defmodule GitExploring.Formatter do

  def parse_commits_from_log( output ) do
    output_parsed = "\n\n" <> output |> String.split("\n\ncommit")
    [_ | commits_descriptions] = output_parsed
    commits_descriptions
  end

  def parse_commit_references( commit ) do
    [hash, author, date, description] = commit |> String.split("\n") |> get_refs()
    [_, author_email, _] = author |> String.split(["<", ">"])
    [_, commit_date] = date |> String.split("   ")
    { String.trim(hash), author_email, commit_date, String.trim(description) }
  end

  def get_refs( commit ) when length(commit) == 5 do
    [hash, author, date, _empty, description] = commit
    [hash, author, date, description]
  end
  def get_refs( commit ) when length(commit) == 6 do
    [hash, author, date, _empty, description, _empty] = commit
    [hash, author, date, description]
  end

end
