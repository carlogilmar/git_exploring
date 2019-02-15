defmodule GitExploring.LogFormatter do

  @doc " ### Main Module  ###"
  def get_commit_lines_from_log( output_from_log ) do
    output_from_log
      |> parse_commits_from_log()
      |> build_commit_references_as_tuples_from_log()
      |> List.flatten()
  end

  def parse_commits_from_log( output ) do
    output_parsed = "\n\n" <> output |> String.split("\n\ncommit")
    [_ | commits_descriptions] = output_parsed
    commits_descriptions
  end

  def build_commit_references_as_tuples_from_log( commit_lines) do
    for commit <- commit_lines, do: parse_commit_references( commit )
  end

  @doc " ### Build commit references as tuples from log  ###"
  def parse_commit_references( commit ) do
    commit = commit |> String.split("\n")
    commit_length = commit |> length()
    case commit_length do
      5 -> get_refs_from_commit( commit )
      6 -> get_refs_from_merge( commit )
      _ -> get_refs_from_squash( commit )
    end
  end

  def get_refs_from_commit( commit ) do
    [hash, author, date, _empty, description] = commit
    parse_references_for_create_commit( [hash, author, date, description] )
  end

  def get_refs_from_merge( commit )do
    [ c1, c2, c3, c4, c5, c6] = commit
    case c5 do
      "" -> parse_references_for_create_commit( [c1, c3, c4, c6] )
      _ -> parse_references_for_create_commit( [c1, c2, c3, c5] )
    end
  end

  def get_refs_from_squash( commit ) do
    [ hash | [author | [ date | commits_tail] ] ] = commit
    commits_tail
      |> clean_empty_spaces_from_squash_tail()
      |> create_commits_bunch_from_squash_tail( hash, author, date )
  end

  @doc " ### Getting commit references from squash commit ###"
  def clean_empty_spaces_from_squash_tail( squash_commits_messy ) do
    commits_without_spaces = for c <- squash_commits_messy, do: String.trim( c )
    Enum.filter( commits_without_spaces, fn c -> c != "" end)
  end

  def create_commits_bunch_from_squash_tail( commits, hash, author, date ) do
    for c <- commits, do: parse_references_for_create_commit( [hash, author, date, c] )
  end

  @doc " ### Utils ###"
  def parse_references_for_create_commit( [hash, author, date, description] ) do
    [_, author_email, _] = author |> String.split(["<", ">"])
    [_, commit_date] = date |> String.split("   ")
    { String.trim(hash), author_email, commit_date, String.trim(description) }
  end
end
