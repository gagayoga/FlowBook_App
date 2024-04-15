class Endpoint {
  static const String baseUrlApi =
      "http://192.168.43.21:8000/api/users/";

  // Authenticated
  static const String register = "${baseUrlApi}registrasi";
  static const String login = "${baseUrlApi}login";
  static const String logout = "${baseUrlApi}logout";
  static const String getDataProfile = "${baseUrlApi}get-profile";
  static const String updateProfile = "${baseUrlApi}update/profile";

  // Buku
  static const String buku = baseUrlApi;
  static const String kategori = "${baseUrlApi}kategori";
  static const String bukuNew = "${baseUrlApi}buku/new";
  static const String bukuPopular = "${baseUrlApi}popular/buku";
  static const String kategoriBuku = "${baseUrlApi}kategori";
  static const String detailBook = "${baseUrlApi}buku/detail";
  static const String searchBuku = "${baseUrlApi}buku/search";
  static const String bukuByKategori = "${baseUrlApi}buku/kategori";

  // KoleksiBuku
  static const String koleksiBook = "${baseUrlApi}koleksi";
  static const String hapusKoleksi = "${baseUrlApi}";

  // Ulasan Buku
  static const String ulasanBuku = "${baseUrlApi}ulasan";

  // Peminjaman
  static const String pinjamBuku = "${baseUrlApi}pinjam";
  static const String detailPeminjaman = "${baseUrlApi}detail/pinjam";
}