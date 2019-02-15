defmodule GitExploring do

  alias GitExploring.Formatter

  def start_analysis( file_path ) do
    {resp, _code} = System.cmd("git", ["status"], cd: file_path)
    case resp do
      "" -> IO.puts "Git Project not found! Please select a project using git..."
      _ -> reading_commits( file_path )
    end
  end

  def reading_commits( file_path ) do
    {output_from_log, _code} = System.cmd("git", ["log", "--all"], cd: file_path)
    output_from_log |> Formatter.get_commit_lines()
  end


end
