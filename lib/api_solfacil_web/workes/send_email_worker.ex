defmodule ApiSolfacilWeb.SendEmailWorker do
    use Oban.Worker, queue: :events

    alias ApiSolfacil.Zips

    require Logger

    @impl Oban.Worker
    def perform(%Oban.Job{args: %{"email" => email} = args}) do
        Logger.info("Start work")
        text = find_zips_code() 
        |> formatter_map([]) 
        |> build_string()

        generate_csv(text)
        |> send_to_email
        :ok
    end

    ## Take all zips-code
    defp find_zips_code(), do: Zips.list_zips()

    ## Format map
    defp formatter_map([h | t], list) do
        formatted = h |> Map.from_struct |> Map.drop([:__meta__, :inserted_at, :updated_at, :id])
        formatter_map(t, list ++ [formatted])
    end
    defp formatter_map([], list), do: list

    ## Build text to send
    defp build_string(list, message \\ "")
    defp build_string([h | t], message) do
        message = """
        #{message}\n
        bairro: #{h.bairro}, cep:  #{h.cep}, complemento:  #{h.complemento}, ddd:  #{h.ddd}, gia:  #{h.gia}, ibge:  #{h.ibge}, localidade:  #{h.localidade}, 
        logradouro:  #{h.logradouro}, siafi:  #{h.siafi}, uf:  #{h.uf};
        """
        |> String.trim

        build_string(t, message)
    end
    defp build_string([], message), do: message

    ## Generate cvs
    defp generate_csv(text), do: File.write("lib/api_solfacil_web/workes/files/archive.csv", text)

    ## Send arquivo
    defp send_to_email(arq) when arq == :ok, do
    end
    defp send_to_email(_) do
    end
end