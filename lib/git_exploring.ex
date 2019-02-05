defmodule GitExploring do

  alias GitExploring.Binnacle

  def start_analysis( file_path ) do
    {resp, _code} = System.cmd("git", ["status"], cd: file_path)
    case resp do
      "" -> IO.puts "Please select a project using git..."
      _ -> Binnacle.reading_commits( file_path )
    end
  end


end
