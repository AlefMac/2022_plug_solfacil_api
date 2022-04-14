# ApiSolfacil

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

### Routes

we have four routes in our application

```elixir
scope "/api", ApiSolfacilWeb do
    pipe_through :api

    post "/solfacil/register", AccountsController, :create

    post "/solfacil/login", AccountsController, :index

    get "/solfacil/:zip", ApiController, :show

    get "/solfacil/get/csv", ApiController, :upload
end
```


The first route you can register with "email" and "password",

The second route you can authenticate yourself,

The third route you can search for a specific zip code

The fourth route you will receive in the email a csv file a list of searched zip codes or a failure txt file


### params

```json
{
  "email":"some_email@example.com",
  "password":"******"
}
```
