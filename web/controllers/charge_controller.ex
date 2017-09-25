defmodule Loudsa.ChargeController do
  use Loudsa.Web, :controller

  def create(conn, %{"card_nonce" => card_nonce, "amount" => amount}) do
    json conn, %{well: "done"}
  end
end

