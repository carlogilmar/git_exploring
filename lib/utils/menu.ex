defmodule GitExploring.Menu do

  alias GitExploring.LogFormatter
  alias GitExploring.CommitDescriptionsAnalyzer
  alias GitExploring.BranchUtil

  def reading_git_log(file_path) do
    ["log", "--all"]
      |> apply_git_command(file_path)
      |> LogFormatter.get_commit_lines_from_log()
  end

  def getting_all_branches(file_path) do
    ["branch", "-r"]
      |> apply_git_command(file_path)
      |> BranchUtil.list_branches()
  end

  def getting_most_useful_words(file_path) do
    file_path
      |> reading_git_log()
      |> CommitDescriptionsAnalyzer.analyzer_commits_words()
  end

  def describe_branch(file_path, reference) do
    file_path
      |> reading_git_log()
      |> Enum.filter(fn {_ref, _author, _date, desc} -> String.contains?(desc, reference) end)
  end

  def apply_git_command(commands, file_path) do
    {output, _code} = System.cmd("git", commands, cd: file_path)
    output
  end

end
