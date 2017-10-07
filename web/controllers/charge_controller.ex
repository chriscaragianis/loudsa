defmodule Loudsa.ChargeController do
  use Loudsa.Web, :controller

  def create(conn, %{
    "card_nonce" => card_nonce,
    "amount" => amount,
    "location_id" => location_id
  }) do
    {:ok, body} = Poison.encode(%{
      idempotency_key: SecureRandom.uuid,
      amount_money: %{
        amount: amount,
        currency: "USD"
      },
      card_nonce: card_nonce,
    })
    HTTPotion.post(
      "https://connect.squareup.com/v2/locations/#{System.get_env("SQUARE_LOCATION")}/transactions",
      [
        body: body,
        headers: [
          "Content-Type": "application-json",
          "Authorization": "Bearer #{System.get_env("SQUARE_TOKEN")}"
        ]
      ]
    )
    |> Poison.encode
    |> IO.inspect
    json conn, %{well: "done"}
  end

  def options() do
  end
end


