defmodule GitExploring.Formatter do

  def get_commit_lines( output_from_log ) do
    commit_lines = parse_commits_from_log( output_from_log )
    for commit <- commit_lines, do: parse_commit_references( commit )
  end

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

  def get_refs( commit ) do
    case length(commit) do
      5 -> get_refs_from_commit( commit )
      6 -> get_refs_from_merge( commit )
      _ -> get_refs_from_squash( commit )
    end
  end

  def get_refs_from_commit( commit ) do
    [hash, author, date, _empty, description] = commit
    [hash, author, date, description]
  end

  def get_refs_from_merge( commit )do
    [ c1, c2, c3, c4, c5, c6] = commit
    case c5 do
      "" -> [ c1, c3, c4, c6]
      _ -> [ c1, c2, c3, c5 ]
    end
  end

  def get_refs_from_squash( commit ) do
    [ hash | [author | [ date | commits_tail] ] ] = commit
    commits_tail
      |> clean_data_from_empty_spaces()
      |> create_commits_bunch_from_squash( hash, author, date )
  end

  def clean_data_from_empty_spaces( squash_commits_messy ) do
    commits_without_spaces = for c <- squash_commits_messy, do: String.trim( c )
    Enum.filter( commits_without_spaces, fn c -> c != "" end)
  end

  def create_commits_bunch_from_squash( commits, hash, author, date ) do
    for c <- commits, do: [hash, author, date, c]
  end

end
