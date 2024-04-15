/// Status : 200
/// Message : "Berhasil menampilkan data buku berdasarkan kategori 2"
/// data : [{"BukuID":1,"CoverBuku":"http://192.168.4.65:8000/storage/images/coverbook/Sang Pemimpi.png","Judul":"Sang Pemimpi","Deskripsi":"Dalam cerita Laskar Pelangi, kita mengenal Ikal sebagai tokoh aku. Di novel Sang Pemimpi, masa SMA Ikal ini akan diceritakan. Bersama Arai dan Jimbron, semangat Ikal untuk menjelajahi Eropa hingga Afrika akan tergugah. Hal ini tak lepas dari campur tangan guru mereka.\n\nJudul “Sang Pemimpi” agaknya sangat cocok dengan karakter novel yang menggugah semangat ini. Novel ini bisa membangkitkan harapan dan menginspirasi, meskipun melalui jalan kemiskinan dan masalah sosial yang berlika-liku. Terlebih, penulisnya membeberkan komentar tentang masalah sosial dengan nada jenaka, membuat pembacanya tertawa miris dalam ironi.\n\nDi dunia nyata, pada dasarnya kita tak melulu dapat termotivasi. Namun, novel ini dipandang sebagai cerita yang realistis daripada menyuapi kita dengan cerita dunia yang pesimis, sehingga sudut pandangnya melihat berbagai kemungkinan untuk menggapai mimpi. Meski hidup dalam kenyataan menjadi orang miskin di Belitung, Ikal bisa menyadari bahwa melakukan hal terbaik yang bisa dilakukan saat ini adalah langkah paling realistis dari pemikiran apa pun.","Penulis":"Andrea Hirata","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":5,"Total_ulasan":1,"JumlahRating":5,"JumlahPeminjam":0,"Status":"Popular"},{"BukuID":2,"CoverBuku":"http://192.168.4.65:8000/storage/images/coverbook/The Principles of Power.png","Judul":"The Principles of Power","Deskripsi":"Dalam cerita Laskar Pelangi, kita mengenal Ikal sebagai tokoh aku. Di novel Sang Pemimpi, masa SMA Ikal ini akan diceritakan. Bersama Arai dan Jimbron, semangat Ikal untuk menjelajahi Eropa hingga Afrika akan tergugah. Hal ini tak lepas dari campur tangan guru mereka.\n\nJudul “Sang Pemimpi” agaknya sangat cocok dengan karakter novel yang menggugah semangat ini. Novel ini bisa membangkitkan harapan dan menginspirasi, meskipun melalui jalan kemiskinan dan masalah sosial yang berlika-liku. Terlebih, penulisnya membeberkan komentar tentang masalah sosial dengan nada jenaka, membuat pembacanya tertawa miris dalam ironi.\n\nDi dunia nyata, pada dasarnya kita tak melulu dapat termotivasi. Namun, novel ini dipandang sebagai cerita yang realistis daripada menyuapi kita dengan cerita dunia yang pesimis, sehingga sudut pandangnya melihat berbagai kemungkinan untuk menggapai mimpi. Meski hidup dalam kenyataan menjadi orang miskin di Belitung, Ikal bisa menyadari bahwa melakukan hal terbaik yang bisa dilakukan saat ini adalah langkah paling realistis dari pemikiran apa pun.","Penulis":"Andrea Hirata","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":5,"Total_ulasan":1,"JumlahRating":5,"JumlahPeminjam":1,"Status":"Popular"},{"BukuID":3,"CoverBuku":"http://192.168.4.65:8000/storage/images/coverbook/Bumi Cinta.png","Judul":"Bumi Cinta","Deskripsi":"Dalam cerita Laskar Pelangi, kita mengenal Ikal sebagai tokoh aku. Di novel Sang Pemimpi, masa SMA Ikal ini akan diceritakan. Bersama Arai dan Jimbron, semangat Ikal untuk menjelajahi Eropa hingga Afrika akan tergugah. Hal ini tak lepas dari campur tangan guru mereka.\n\nJudul “Sang Pemimpi” agaknya sangat cocok dengan karakter novel yang menggugah semangat ini. Novel ini bisa membangkitkan harapan dan menginspirasi, meskipun melalui jalan kemiskinan dan masalah sosial yang berlika-liku. Terlebih, penulisnya membeberkan komentar tentang masalah sosial dengan nada jenaka, membuat pembacanya tertawa miris dalam ironi.\n\nDi dunia nyata, pada dasarnya kita tak melulu dapat termotivasi. Namun, novel ini dipandang sebagai cerita yang realistis daripada menyuapi kita dengan cerita dunia yang pesimis, sehingga sudut pandangnya melihat berbagai kemungkinan untuk menggapai mimpi. Meski hidup dalam kenyataan menjadi orang miskin di Belitung, Ikal bisa menyadari bahwa melakukan hal terbaik yang bisa dilakukan saat ini adalah langkah paling realistis dari pemikiran apa pun.","Penulis":"Habibiburrahman","Penerbit":"Naver Webtoon","TahunTerbit":"2013","JumlahHalaman":"438","Rating":0,"Total_ulasan":0,"JumlahRating":0,"JumlahPeminjam":0,"Status":"Tidak Populer"}]

class ResponseBookBykategori {
  ResponseBookBykategori({
      this.status, 
      this.message, 
      this.data,});

  ResponseBookBykategori.fromJson(dynamic json) {
    status = json['Status'];
    message = json['Message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataBookKategori.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<DataBookKategori>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['Message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// BukuID : 1
/// CoverBuku : "http://192.168.4.65:8000/storage/images/coverbook/Sang Pemimpi.png"
/// Judul : "Sang Pemimpi"
/// Deskripsi : "Dalam cerita Laskar Pelangi, kita mengenal Ikal sebagai tokoh aku. Di novel Sang Pemimpi, masa SMA Ikal ini akan diceritakan. Bersama Arai dan Jimbron, semangat Ikal untuk menjelajahi Eropa hingga Afrika akan tergugah. Hal ini tak lepas dari campur tangan guru mereka.\n\nJudul “Sang Pemimpi” agaknya sangat cocok dengan karakter novel yang menggugah semangat ini. Novel ini bisa membangkitkan harapan dan menginspirasi, meskipun melalui jalan kemiskinan dan masalah sosial yang berlika-liku. Terlebih, penulisnya membeberkan komentar tentang masalah sosial dengan nada jenaka, membuat pembacanya tertawa miris dalam ironi.\n\nDi dunia nyata, pada dasarnya kita tak melulu dapat termotivasi. Namun, novel ini dipandang sebagai cerita yang realistis daripada menyuapi kita dengan cerita dunia yang pesimis, sehingga sudut pandangnya melihat berbagai kemungkinan untuk menggapai mimpi. Meski hidup dalam kenyataan menjadi orang miskin di Belitung, Ikal bisa menyadari bahwa melakukan hal terbaik yang bisa dilakukan saat ini adalah langkah paling realistis dari pemikiran apa pun."
/// Penulis : "Andrea Hirata"
/// Penerbit : "Naver Webtoon"
/// TahunTerbit : "2013"
/// JumlahHalaman : "438"
/// Rating : 5
/// Total_ulasan : 1
/// JumlahRating : 5
/// JumlahPeminjam : 0
/// Status : "Popular"

class DataBookKategori {
  DataBookKategori({
      this.bukuID, 
      this.coverBuku, 
      this.judul, 
      this.deskripsi, 
      this.penulis, 
      this.penerbit, 
      this.tahunTerbit, 
      this.jumlahHalaman, 
      this.rating, 
      this.totalUlasan, 
      this.jumlahRating, 
      this.jumlahPeminjam, 
      this.status,});

  DataBookKategori.fromJson(dynamic json) {
    bukuID = json['BukuID'];
    coverBuku = json['CoverBuku'];
    judul = json['Judul'];
    deskripsi = json['Deskripsi'];
    penulis = json['Penulis'];
    penerbit = json['Penerbit'];
    tahunTerbit = json['TahunTerbit'];
    jumlahHalaman = json['JumlahHalaman'];
    rating = json['Rating'].toDouble();
    totalUlasan = json['Total_ulasan'];
    jumlahRating = json['JumlahRating'];
    jumlahPeminjam = json['JumlahPeminjam'];
    status = json['Status'];
  }
  int? bukuID;
  String? coverBuku;
  String? judul;
  String? deskripsi;
  String? penulis;
  String? penerbit;
  String? tahunTerbit;
  String? jumlahHalaman;
  double? rating;
  int? totalUlasan;
  int? jumlahRating;
  int? jumlahPeminjam;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BukuID'] = bukuID;
    map['CoverBuku'] = coverBuku;
    map['Judul'] = judul;
    map['Deskripsi'] = deskripsi;
    map['Penulis'] = penulis;
    map['Penerbit'] = penerbit;
    map['TahunTerbit'] = tahunTerbit;
    map['JumlahHalaman'] = jumlahHalaman;
    map['Rating'] = rating;
    map['Total_ulasan'] = totalUlasan;
    map['JumlahRating'] = jumlahRating;
    map['JumlahPeminjam'] = jumlahPeminjam;
    map['Status'] = status;
    return map;
  }

}