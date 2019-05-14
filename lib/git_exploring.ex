defmodule GitExploring do

  alias GitExploring.Menu

  def start_analysis(file_path, command) do
    set_menu = fn
      {:commits} -> Menu.reading_git_log(file_path)
      {:words} -> Menu.getting_most_useful_words(file_path)
      {:branches} -> Menu.getting_all_branches(file_path)
      {:commits_by_branch, reference} -> Menu.describe_branch(file_path, reference)
    end
    resp = Menu.apply_git_command(["status"], file_path)
    case resp do
      "" -> raise "Git Project not found! Please select a project using git..."
      _git -> set_menu.(command)
    end
  end

end
