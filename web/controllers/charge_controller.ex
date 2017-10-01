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
      "https://connect.squareup.com/v2/locations/#{location_id}/transactions",
      [
        body: body,
        headers: [
          "Content-Type": "application-json",
          "Authorization": "Bearer <TOKEN HERE>"
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


