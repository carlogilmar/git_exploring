defmodule GitExploring.Binnacle do

  alias GitExploring.Formatter

  def reading_commits( file_path ) do
    {output_from_log, _code} = System.cmd("git", ["log", "--all"], cd: file_path)
    commits = output_from_log |> get_commit_lines()
    #TODO: find a better way to make this:
    list_all_users( commits )
  end

  def get_commit_lines( output_from_log ) do
    commit_lines = Formatter.parse_commits_from_log( output_from_log )
    for commit <- commit_lines do
      Formatter.parse_commit_references( commit )
    end
  end

  def list_all_users( commits ) do
    authors = for {_hash, author, _date, _desc}  <- commits, do: author
    Enum.uniq( authors )
  end

end
