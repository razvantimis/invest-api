defmodule InvestData.Utils.DateHelper do
  def get_last_day_of_week() do
    today = Date.utc_today()
    week_day = today |> Date.day_of_week()

    case week_day do
      7 -> today |> Date.add(-2)
      6 -> today |> Date.add(-1)
      _ -> today
    end
  end

  def get_start_of_day(date) do
    DateTime.new!(date, Time.new!(0, 0, 0, 0))
  end

  def get_end_of_day(date) do
    DateTime.new!(date, Time.new!(23, 59, 59, 999_999))
  end

  def get_start_and_end_of_day(date) do
    %{
      :start_date => get_start_of_day(date),
      :end_date => get_end_of_day(date)
    }
  end

  # defp format_date(date) do
  #   [date.year, date.month, date.day]
  #   |> Enum.map(&to_string/1)
  #   |> Enum.map_join("-", &String.pad_leading(&1, 2, "0"))
  # end
end
