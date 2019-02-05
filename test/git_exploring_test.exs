defmodule GitExploringTest do
  use ExUnit.Case
  alias GitExploring.Formatter

  test "Format a log output" do
    output = "commit 83a225d21466008eaa720f44f96497d7aa11382a\nAuthor: carlogilmar <carlogilmar12@gmail.com>\nDate:   Mon Feb 4 20:45:57 2019 -0600\n\n    Other commit\n\ncommit 57a435e7472633b27d6a7ada684359a6102d864e\nAuthor: carlogilmar <carlogilmar12@gmail.com>\nDate:   Mon Feb 4 20:45:57 2019 -0600\n\n    Other commit\n\ncommit 089e930e8f5a044411a5a5b657f3f42426f03cdb\nAuthor: carlogilmar <carlogilmar12@gmail.com>\nDate:   Mon Feb 4 20:45:56 2019 -0600\n\n    Other commit\n\ncommit 313926f66117f91284fef0a40b4077dd73dbe158\nAuthor: carlogilmar <carlogilmar12@gmail.com>\nDate:   Mon Feb 4 20:45:55 2019 -0600\n\n    Other commit\n\ncommit c6ebd50c336cc392a2ccb826742ba9f478a9ab95\nAuthor: carlogilmar <carlogilmar12@gmail.com>\nDate:   Mon Feb 4 20:45:52 2019 -0600\n\n    Other commit\n\ncommit 525cc3ce78f7237e271ff3dba7d4a8ae9ab5ed76\nAuthor: carlogilmar <carlogilmar12@gmail.com>\nDate:   Mon Feb 4 20:05:55 2019 -0600\n\n    Adding first commit\n"
    commits = Formatter.parse_commits_from_log( output )
    assert length(commits) == 6
  end

end
