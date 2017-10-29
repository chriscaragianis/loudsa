defmodule Loudsa.Api.Email do
  @domain Application.get_env(:loudsa, :mailgun_domain)
  @key Application.get_env(:loudsa, :mailgun_key)
  @auth { "api", @key }

  def build_email_req(email_body) do
    [
      body: email_body,
      headers: [
        "User-Agent": "LouDSA",
        "Content-Type": "application/x-www-form-urlencoded",
      ]
      basic_auth: @auth
    ]
  end

  def send_email(email) do
    HTTPotion.post(
      @domain,
      email
    )
  end


end


# Email Schema
# %{
#    from
#    to
#    subject
#    date
#    last_sent
#
# }
