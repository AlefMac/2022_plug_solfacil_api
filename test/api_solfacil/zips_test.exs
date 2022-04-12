defmodule ApiSolfacil.ZipsTest do
  use ApiSolfacil.DataCase

  alias ApiSolfacil.Zips

  describe "zips" do
    alias ApiSolfacil.Zips.Zip

    import ApiSolfacil.ZipsFixtures

    @invalid_attrs %{complement: nil, ddd: nil, district: nil, gia: nil, ibge: nil, locality: nil, public_place: nil, siafi: nil, uf: nil, zip_code: nil}

    test "list_zips/0 returns all zips" do
      zip = zip_fixture()
      assert Zips.list_zips() == [zip]
    end

    test "get_zip!/1 returns the zip with given id" do
      zip = zip_fixture()
      assert Zips.get_zip!(zip.id) == zip
    end

    test "create_zip/1 with valid data creates a zip" do
      valid_attrs = %{complement: "some complement", ddd: "some ddd", district: "some district", gia: "some gia", ibge: "some ibge", locality: "some locality", public_place: "some public_place", siafi: "some siafi", uf: "some uf", zip_code: "some zip_code"}

      assert {:ok, %Zip{} = zip} = Zips.create_zip(valid_attrs)
      assert zip.complement == "some complement"
      assert zip.ddd == "some ddd"
      assert zip.district == "some district"
      assert zip.gia == "some gia"
      assert zip.ibge == "some ibge"
      assert zip.locality == "some locality"
      assert zip.public_place == "some public_place"
      assert zip.siafi == "some siafi"
      assert zip.uf == "some uf"
      assert zip.zip_code == "some zip_code"
    end

    test "create_zip/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Zips.create_zip(@invalid_attrs)
    end

    test "update_zip/2 with valid data updates the zip" do
      zip = zip_fixture()
      update_attrs = %{complement: "some updated complement", ddd: "some updated ddd", district: "some updated district", gia: "some updated gia", ibge: "some updated ibge", locality: "some updated locality", public_place: "some updated public_place", siafi: "some updated siafi", uf: "some updated uf", zip_code: "some updated zip_code"}

      assert {:ok, %Zip{} = zip} = Zips.update_zip(zip, update_attrs)
      assert zip.complement == "some updated complement"
      assert zip.ddd == "some updated ddd"
      assert zip.district == "some updated district"
      assert zip.gia == "some updated gia"
      assert zip.ibge == "some updated ibge"
      assert zip.locality == "some updated locality"
      assert zip.public_place == "some updated public_place"
      assert zip.siafi == "some updated siafi"
      assert zip.uf == "some updated uf"
      assert zip.zip_code == "some updated zip_code"
    end

    test "update_zip/2 with invalid data returns error changeset" do
      zip = zip_fixture()
      assert {:error, %Ecto.Changeset{}} = Zips.update_zip(zip, @invalid_attrs)
      assert zip == Zips.get_zip!(zip.id)
    end

    test "delete_zip/1 deletes the zip" do
      zip = zip_fixture()
      assert {:ok, %Zip{}} = Zips.delete_zip(zip)
      assert_raise Ecto.NoResultsError, fn -> Zips.get_zip!(zip.id) end
    end

    test "change_zip/1 returns a zip changeset" do
      zip = zip_fixture()
      assert %Ecto.Changeset{} = Zips.change_zip(zip)
    end
  end
end
