defmodule GitExploring do

  def start_analysis( file_path ) do
    {resp, _code} = System.cmd("git", ["status"], cd: file_path)
    case resp do
      "" -> IO.puts "Please select a project using git..."
      _ -> IO.puts "Starting..."
    end
  end

end
