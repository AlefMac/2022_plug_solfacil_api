defmodule ApiSolfacilWeb.AccountsController do
    @moduledoc """
    module responsible for registering and validating user
    """
    use Phoenix.Controller
    use Joken.Config

    import Pbkdf2
    import ApiSolfacilWeb.TokenManager

    alias ApiSolfacil.Accounts
    alias ApiSolfacil.Accounts.User
    alias ApiSolfacil.Accounts.Tokens

    @doc """
    create new user
    """
    def create(conn, params) do
        create = Accounts.create_user(params)

        case create do
            {:ok, _user} ->
                json(conn, %{
                    "status" => true,
                    "message" => "user created"
                })

            {:error, reason} ->
                json(conn, %{
                    "status" => false,
                    "errors" =>
                        Enum.map(reason.errors, fn {key, reason} ->
                            {head, _} = reason
                            %{key => head}
                        end),
                    "message" => "user not created"
                })
        end
    end

    @doc """
    validate user
    """
    def index(conn, %{"email" => email, "password" => password}) do
        account = Accounts.get_user_by_email(email) 
        case account do
            %User{} ->
                compare_password = Pbkdf2.verify_pass(password, account.password)
                if compare_password do
                    token = generate_token(email)
                    token_save = token |> Enum.at(0)
                    attrs = %{
                        "email_id" => account.id,
                        "token" => token_save
                    }

                    find_token = Accounts.get_token_by_id(account.id)

                    if find_token, do: nil, else: Accounts.create_user_token(attrs)

                    json(conn,%{
                        "status" => true,
                        "message" => "user found",
                        "token_access" => token_save
                    })
                else
                    json(conn, 
                        %{
                            "status" => false,
                            "message" => "user not found"
                        }
                    )
                end
            
            _ -> 
                json(conn, 
                    %{
                        "status" => false,
                        "message" => "user not found"
                    }
                )
        end
    end
end
