defmodule GitExploring.Formatter do

  def parse_commits_from_log( output ) do
    output_parsed = "\n\n" <> output |> String.split("\n\ncommit")
    [_ | commits_descriptions] = output_parsed
    commits_descriptions
  end

end
