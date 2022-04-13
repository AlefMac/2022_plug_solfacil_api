defmodule ApiSolfacilWeb.ApiControllerTest do
    use ApiSolfacilWeb.ConnCase, async: true

    alias ApiSolfacilWeb.ApiController

    describe "show/2" do
        test "if response message error", %{conn: conn} do
            conn = get(conn, Routes.api_controller_path(conn, :show))
            IO.inspect conn
        end
    end
end