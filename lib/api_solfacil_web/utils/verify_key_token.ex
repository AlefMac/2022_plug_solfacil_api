defmodule ApiSolfacilWeb.VerifyKeyToken do

    def verify_key([h | t]) do
        {key, _} = h

        if key == "authorization" do
            h
        else
            verify_key(t)
        end
    end
    
    def verify_key([]), do: {:error, ""}
end