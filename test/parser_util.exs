defmodule ParserUtilTest do
  use ExUnit.Case
  alias GitExploring.ParserUtil

  test "Parse date" do
    date = "Mon Feb 4 20:39:36 2019 -0600"
    date_parsed = ParserUtil.parse_date(date)
    assert date_parsed ==  ~D[2019-02-04]
  end
end
