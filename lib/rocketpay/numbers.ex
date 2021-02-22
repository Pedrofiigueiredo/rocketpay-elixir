defmodule Rocketpay.Numbers do
  @moduledoc """
  Handles number.csv file
  """

  def sum_from_file(filename) do
    # file = File.read("#{filename}.csv")
    # handle_file(file)

    # PIPE OPERATOR
    # Passa o retorno da linha anterior como 1o parâmetro
    "#{filename}.csv"
    |> File.read()
    |>handle_file()
  end

  # defp handle_file({:ok, file}), do: filename

  defp handle_file({:ok, result}) do
    # Sem PIPE
    # result = String.split(result, ",")
    # result = Enum.map(result, fn number -> String.to_integer(number) end)
    # result = Enum.sum(result)
    # result  # A última linha é o retorno da func

    # Com PIPE
    result =
      result
      |> String.split(",")
      |> Stream.map(fn number -> String.to_integer(number) end)
      |> Enum.sum()

    {:ok, %{result: result}}
  end

  defp handle_file({:error, _reason}), do: {:error, %{message: "invalid file"}}
end
