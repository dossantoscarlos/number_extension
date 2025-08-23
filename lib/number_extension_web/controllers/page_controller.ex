defmodule NumberExtensionWeb.PageController do
  use NumberExtensionWeb, :controller

  def home(conn, params) do
    result =
      case conn.method do
        "POST" -> handle_post(params)
        "GET" -> nil
      end

    render(conn, :home, result: result, csrf_token: Plug.CSRFProtection.get_csrf_token())
  end

  defp handle_post(params) do
    case Map.get(params, "number") do
      nil ->
        nil

      number_string ->
        convert_number_to_words(number_string)
    end
  end

  defp convert_number_to_words(number_string) do
    try do
      number = String.to_integer(number_string)
      {:ok, text} = NumberExtension.Cldr.Number.to_string(number, format: :spellout)
      "#{String.upcase(text)}"
    rescue
      ArgumentError ->
        "Entrada inválida. Por favor, insira um número."
    end
  end
end
