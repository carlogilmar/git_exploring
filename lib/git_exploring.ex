defmodule GitExploring do

  alias GitExploring.Menu

  def start_analysis(file_path, command) do
    apply_menu = fn
      {"", _command} -> raise "Git Project not found! Please select a project using git..."
      {_git, {:commits}} -> Menu.reading_git_log(file_path)
      {_git, {:words}} -> Menu.getting_most_useful_words(file_path)
      {_git, {:branches}} -> Menu.getting_all_branches(file_path)
      {_git, {:commits_by_branch, reference}} -> Menu.describe_branch(file_path, reference)
    end
    resp = Menu.apply_git_command(["status"], file_path)
    apply_menu.({resp, command})
  end

end
