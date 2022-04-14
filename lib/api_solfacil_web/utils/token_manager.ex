defmodule ApiSolfacilWeb.TokenManager do

    def verify_key([h | t]) do
        {key, _} = h

        if key == "authorization", do: h, else: verify_key(t)
    end
    def verify_key([]), do: {:error, ""}


    ## Generating the jwt
    def generate_token(email) do
        token_config = %{} # empty config
        token_config = Map.put(token_config, "email", %Joken.Claim{
            generate: fn -> email 
        end})
        signer = Joken.Signer.create("HS256", "secret")
        {:ok, claims} = Joken.generate_claims(token_config, %{"extra"=> "api"})
        {:ok, jwt, claims} = Joken.encode_and_sign(claims, signer)
        [jwt, claims]
    end
end