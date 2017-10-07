defmodule Loudsa.EmailController do
  use Loudsa.Web, :controller
  @domain Application.get_env(:loudsa, :mailgun_domain)
  @key Application.get_env(:loudsa, :mailgun_key)
  @auth { "api", @key }

  def create(conn, %{
    "name" => name,
    "street" => street,
    "city" => city,
    "state" => state,
    "zip" => zip,
    "email" => email,
    "order" => order,
    "message" => message
  }) do
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

    Sent from dsalouisville.org
    ", %{
      name: name,
      email: email,
      street: street,
      city: city,
      state: state,
      zip: zip,
      message: message,
      shirts: order["shirts"],
      glasses: order["glasses"],
      buttons: order["buttons"],
      buttonPacks: order["buttonPacks"]
    })
     body = %{
      "from" => "mailgun@sandbox7b54c5b21f104f7288483d9692f69872.mailgun.org",
      "to" => "dsalouisville@gmail.com",
      "subject" =>  "Incoming Order! (not really)",
      "text" => email_text
    }
    |> URI.encode_query
    |> IO.inspect
    resp = HTTPotion.post(
      @domain,
      [
        body: body,
        headers: [
          "User-Agent": "LouDSA",
          "Content-Type": "application/x-www-form-urlencoded",
        ],
        basic_auth: @auth
      ]
    )
    json conn, %{resp: resp}
  end

  def options() do
  end
end

