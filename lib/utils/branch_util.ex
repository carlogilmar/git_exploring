defmodule GitExploring.BranchUtil do

  def list_branches(output) do
    [_HEAD | branches] = String.split(output, "\n  ")
    validate_branch_references = fn
      [_origin, feature, reference] -> {"#{feature}/#{reference}", reference}
      [_origin, environment] -> {environment, environment}
    end
    for branch <- branches do
      references = String.split(branch, "/")
      validate_branch_references.(references)
    end
  end

end
