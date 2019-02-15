defmodule GitExploring do

  alias GitExploring.LogFormatter

  def start_analysis( file_path ) do
    {resp, _code} = System.cmd("git", ["status"], cd: file_path)
    case resp do
      "" -> IO.puts "Git Project not found! Please select a project using git..."
      _ -> reading_git_log( file_path )
    end
  end

  def reading_git_log( file_path ) do
    {output_from_log, _code} = System.cmd("git", ["log", "--all"], cd: file_path)
    output_from_log |> LogFormatter.get_commit_lines_from_log()
  end

end
