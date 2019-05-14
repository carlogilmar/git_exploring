defmodule GitExploring.ParserUtil do

  def parse_date(date) do
    [_day, month, day, _hour, year, _] = String.split(date, " ")
    month_number = get_month_number(month)
    day_number = complete_day(day)
    date_for_parse = "#{year}-#{month_number}-#{day_number}"
    {:ok, date_parsed} = Date.from_iso8601(date_for_parse)
    date_parsed
  end

  def complete_day(day) do
    complete = fn
      2 -> day
      1 -> "0#{day}"
    end
    complete.(String.length(day))
  end

  def get_month_number(month) do
    months =
      [
        {"Jan", "01"},
        {"Feb", "02"},
        {"Mar", "03"},
        {"Apr", "04"},
        {"May", "05"},
        {"Jun", "06"},
        {"Jul", "07"},
        {"Aug", "08"},
        {"Sep", "09"},
        {"Oct", "10"},
        {"Nov", "11"},
        {"Dec", "12"}
      ]
    {_desc, month_number} = Enum.find(months, fn {desc, _month} -> desc == month end)
    month_number
  end

end
