defmodule GitExploring.Binnacle do

  def reading_commits( file_path ) do
    {output_from_log, _code} = System.cmd("git", ["log", "--all"], cd: file_path)
    commits = output_from_log |> get_commit_lines()
  end

  def get_commit_lines( output_from_log ) do
    commit_lines = Formatter.parse_commits_from_log( output_from_log )
    for commit <- commit_lines do
      Formatter.parse_commit_references( commit )
    end
  end

end
