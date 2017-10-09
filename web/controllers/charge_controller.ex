defmodule Loudsa.ChargeController do
  use Loudsa.Web, :controller
  @domain Application.get_env(:loudsa, :mailgun_domain)
  @key Application.get_env(:loudsa, :mailgun_key)
  @square_location Application.get_env(:loudsa, :square_location)
  @square_key Application.get_env(:loudsa, :square_key)
  @auth { "api", @key }

  def sendEmail(message, order) do
    email_text = Mustache.render("
    Name: {{name}},
    email: {{email}}

    {{street}}
    {{city}}
    {{state}}
    {{zip}}

    {{message}}

    Shirts: {{shirts}}
    Glasses: {{glasses}}
    Buttons: {{buttons}}
    Button Pax: {{buttonPacks}}

    Order Total: {{total}}

    Sent from dsalouisville.org
    ", %{
      name: message["name"],
      email: message["email"],
      street: message["street"],
      city: message["city"],
      state: message["state"],
      zip: message["zip"],
      message: message["message"],
      shirts: order["shirts"],
      glasses: order["glasses"],
      buttons: order["buttons"],
      buttonPacks: order["buttonPacks"],
      total: order["total"] / 100
    })

    emailBody = %{
      "from" => "mailgun@sandbox7b54c5b21f104f7288483d9692f69872.mailgun.org",
      "to" => "dsalouisville@gmail.com",
      "subject" =>  "Incoming Order! (not really)",
      "text" => email_text
    }
    |> URI.encode_query
    |> IO.inspect
    IO.inspect @domain
    IO.inspect @auth
    emailResp = HTTPotion.post(
      @domain,
      [
        body: emailBody,
        headers: [
          "User-Agent": "LouDSA",
          "Content-Type": "application/x-www-form-urlencoded",
        ],
        basic_auth: @auth
      ]
    )
    {:ok, logEmail} = Poison.encode emailResp
    IO.puts logEmail
  end

  def create(conn, %{
    "card_nonce" => card_nonce,
    "location_id" => location_id,
    "message" => message,
    "order" => order,
    "message" => message
  }) do
    response = %{}
    {:ok, body} = Poison.encode(%{
      idempotency_key: SecureRandom.uuid,
      amount_money: %{
        amount: order["total"],
        currency: "USD"
      },
      card_nonce: card_nonce,
    })
    IO.inspect { @square_location, @square_key }
    chargeResp = HTTPotion.post(
      "https://connect.squareup.com/v2/locations/#{@square_location}/transactions",
      [
        body: body,
        headers: [
          "Content-Type": "application-json",
          "Authorization": "Bearer #{@square_key}"
        ]
      ]
    )
    {:ok, logCharge} = Poison.encode chargeResp
    IO.puts logCharge
    case chargeResp.status_code do
      200 -> sendEmail(message, order)
        put_status(conn, 200)
        json conn, %{well: "done"}
      _ -> put_status(conn, 400)
        json conn, %{well: "done"}
    end
  end

  def options() do
  end
end


