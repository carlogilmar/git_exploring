defmodule GitExploring do

  alias GitExploring.LogFormatter
  alias GitExploring.CommitDescriptionsAnalyzer
  alias GitExploring.BranchUtil

  # Validing if exist a git repo
  def start_analysis(file_path, command) do
    set_menu = fn
      :commits -> reading_git_log(file_path)
      :words -> getting_most_useful_words(file_path)
      :branches -> getting_all_branches(file_path)
    end
    {resp, _code} = System.cmd("git", ["status"], cd: file_path)
    case resp do
      "" -> raise "Git Project not found! Please select a project using git..."
      _ -> set_menu.(command)
    end
  end

  # Read the log
  defp reading_git_log( file_path ) do
    {output_from_log, _code} = System.cmd("git", ["log", "--all"], cd: file_path)
    output_from_log |> LogFormatter.get_commit_lines_from_log()
  end

  # Get useful words
  defp getting_most_useful_words( file_path ) do
    file_path
      |> reading_git_log()
      |> CommitDescriptionsAnalyzer.analyzer_commits_words()
  end

  # Get all remote branches
  defp getting_all_branches(file_path) do
    {output_from_log, _code} = System.cmd("git", ["branch", "-r"], cd: file_path)
    BranchUtil.list_branches(output_from_log)
  end

end
