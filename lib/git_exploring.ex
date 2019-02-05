defmodule GitExploring do

  alias GitExploring.Formatter

  def start_analysis( file_path ) do
    {resp, _code} = System.cmd("git", ["status"], cd: file_path)
    case resp do
      "" -> IO.puts "Please select a project using git..."
      _ -> reading_commits( file_path )
    end
  end

  def reading_commits( file_path ) do
    {output, _code} = System.cmd("git", ["log", "--all"], cd: file_path)
    Formatter.parse_commits_from_log( output )
  end

end
