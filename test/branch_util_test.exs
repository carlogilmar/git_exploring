defmodule BranchUtilTest do
  use ExUnit.Case
  alias GitExploring.BranchUtil

  test "Parse date" do
    {output, _} = {"  origin/HEAD -> origin/master\n  origin/feature/1\n  origin/feature/11\n  origin/feature/12\n  origin/feature/13\n  origin/feature/14\n  origin/feature/15\n  origin/feature/16\n  origin/feature/18\n  origin/feature/19\n  origin/feature/2\n  origin/feature/20\n  origin/feature/21\n  origin/feature/22\n  origin/feature/3\n  origin/feature/38\n  origin/feature/39\n  origin/feature/4\n  origin/feature/41\n  origin/feature/42\n  origin/feature/43\n  origin/feature/44\n  origin/feature/45\n  origin/feature/47\n  origin/feature/49\n  origin/feature/5\n  origin/feature/50\n  origin/feature/52\n  origin/feature/53\n  origin/feature/54\n  origin/feature/55\n  origin/feature/58\n  origin/feature/59\n  origin/feature/6\n  origin/feature/7\n  origin/master\n  origin/production\n  origin/stage\n",
          0}
    branchs = BranchUtil.list_branches(output)
    IO.inspect branchs
    assert length(branchs) == 37
  end
end
