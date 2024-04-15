/// status : 200
/// message : "Berhasil menampilkan data semua buku dan search buku berdasarkan null"
/// data : [{"BukuID":1,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/Buku Latihan Mantappu Jiwa.png","Judul":"Buku Latihan Mantappu Jiwa","Deskripsi":"Dalam cerita Laskar Pelangi, kita mengenal Ikal sebagai tokoh aku. Di novel Sang Pemimpi, masa SMA Ikal ini akan diceritakan. Bersama Arai dan Jimbron, semangat Ikal untuk menjelajahi Eropa hingga Afrika akan tergugah. Hal ini tak lepas dari campur tangan guru mereka.\n\nJudul “Sang Pemimpi” agaknya sangat cocok dengan karakter novel yang menggugah semangat ini. Novel ini bisa membangkitkan harapan dan menginspirasi, meskipun melalui jalan kemiskinan dan masalah sosial yang berlika-liku. Terlebih, penulisnya membeberkan komentar tentang masalah sosial dengan nada jenaka, membuat pembacanya tertawa miris dalam ironi.\n\nDi dunia nyata, pada dasarnya kita tak melulu dapat termotivasi. Namun, novel ini dipandang sebagai cerita yang realistis daripada menyuapi kita dengan cerita dunia yang pesimis, sehingga sudut pandangnya melihat berbagai kemungkinan untuk menggapai mimpi. Meski hidup dalam kenyataan menjadi orang miskin di Belitung, Ikal bisa menyadari bahwa melakukan hal terbaik yang bisa dilakukan saat ini adalah langkah paling realistis dari pemikiran apa pun.","Penulis":"Jerome Polin Sijabat","Penerbit":"Republika","TahunTerbit":"2006","JumlahHalaman":"438","Rating":4.285714285714286,"Total_ulasan":7,"JumlahRating":30,"JumlahPeminjam":7,"Status":"Popular","Keterangan":"Tersimpan"},{"BukuID":2,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/One Piece.png","Judul":"One Piece","Deskripsi":"Dalam cerita Laskar Pelangi, kita mengenal Ikal sebagai tokoh aku. Di novel Sang Pemimpi, masa SMA Ikal ini akan diceritakan. Bersama Arai dan Jimbron, semangat Ikal untuk menjelajahi Eropa hingga Afrika akan tergugah. Hal ini tak lepas dari campur tangan guru mereka.\n\nJudul “Sang Pemimpi” agaknya sangat cocok dengan karakter novel yang menggugah semangat ini. Novel ini bisa membangkitkan harapan dan menginspirasi, meskipun melalui jalan kemiskinan dan masalah sosial yang berlika-liku. Terlebih, penulisnya membeberkan komentar tentang masalah sosial dengan nada jenaka, membuat pembacanya tertawa miris dalam ironi.\n\nDi dunia nyata, pada dasarnya kita tak melulu dapat termotivasi. Namun, novel ini dipandang sebagai cerita yang realistis daripada menyuapi kita dengan cerita dunia yang pesimis, sehingga sudut pandangnya melihat berbagai kemungkinan untuk menggapai mimpi. Meski hidup dalam kenyataan menjadi orang miskin di Belitung, Ikal bisa menyadari bahwa melakukan hal terbaik yang bisa dilakukan saat ini adalah langkah paling realistis dari pemikiran apa pun.","Penulis":"Jerome Polin Sijabat","Penerbit":"Republika","TahunTerbit":"2006","JumlahHalaman":"438","Rating":5,"Total_ulasan":3,"JumlahRating":15,"JumlahPeminjam":5,"Status":"Popular","Keterangan":"Tersimpan"},{"BukuID":3,"CoverBuku":"http://192.168.43.21:8000/storage/images/coverbook/Bicara Itu Ada Seninya.png","Judul":"Bicara Itu Ada Seninya","Deskripsi":"Dalam cerita Laskar Pelangi, kita mengenal Ikal sebagai tokoh aku. Di novel Sang Pemimpi, masa SMA Ikal ini akan diceritakan. Bersama Arai dan Jimbron, semangat Ikal untuk menjelajahi Eropa hingga Afrika akan tergugah. Hal ini tak lepas dari campur tangan guru mereka.\n\nJudul “Sang Pemimpi” agaknya sangat cocok dengan karakter novel yang menggugah semangat ini. Novel ini bisa membangkitkan harapan dan menginspirasi, meskipun melalui jalan kemiskinan dan masalah sosial yang berlika-liku. Terlebih, penulisnya membeberkan komentar tentang masalah sosial dengan nada jenaka, membuat pembacanya tertawa miris dalam ironi.\n\nDi dunia nyata, pada dasarnya kita tak melulu dapat termotivasi. Namun, novel ini dipandang sebagai cerita yang realistis daripada menyuapi kita dengan cerita dunia yang pesimis, sehingga sudut pandangnya melihat berbagai kemungkinan untuk menggapai mimpi. Meski hidup dalam kenyataan menjadi orang miskin di Belitung, Ikal bisa menyadari bahwa melakukan hal terbaik yang bisa dilakukan saat ini adalah langkah paling realistis dari pemikiran apa pun.","Penulis":"Jerome Polin Sijabat","Penerbit":"Republika","TahunTerbit":"2006","JumlahHalaman":"438","Rating":0,"Total_ulasan":0,"JumlahRating":0,"JumlahPeminjam":4,"Status":"Tidak Populer","Keterangan":"Tersimpan"}]

class ResponseAllBook {
  ResponseAllBook({
      this.status, 
      this.message, 
      this.data,});

  ResponseAllBook.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataBook.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<DataBook>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// BukuID : 1
/// CoverBuku : "http://192.168.43.21:8000/storage/images/coverbook/Buku Latihan Mantappu Jiwa.png"
/// Judul : "Buku Latihan Mantappu Jiwa"
/// Deskripsi : "Dalam cerita Laskar Pelangi, kita mengenal Ikal sebagai tokoh aku. Di novel Sang Pemimpi, masa SMA Ikal ini akan diceritakan. Bersama Arai dan Jimbron, semangat Ikal untuk menjelajahi Eropa hingga Afrika akan tergugah. Hal ini tak lepas dari campur tangan guru mereka.\n\nJudul “Sang Pemimpi” agaknya sangat cocok dengan karakter novel yang menggugah semangat ini. Novel ini bisa membangkitkan harapan dan menginspirasi, meskipun melalui jalan kemiskinan dan masalah sosial yang berlika-liku. Terlebih, penulisnya membeberkan komentar tentang masalah sosial dengan nada jenaka, membuat pembacanya tertawa miris dalam ironi.\n\nDi dunia nyata, pada dasarnya kita tak melulu dapat termotivasi. Namun, novel ini dipandang sebagai cerita yang realistis daripada menyuapi kita dengan cerita dunia yang pesimis, sehingga sudut pandangnya melihat berbagai kemungkinan untuk menggapai mimpi. Meski hidup dalam kenyataan menjadi orang miskin di Belitung, Ikal bisa menyadari bahwa melakukan hal terbaik yang bisa dilakukan saat ini adalah langkah paling realistis dari pemikiran apa pun."
/// Penulis : "Jerome Polin Sijabat"
/// Penerbit : "Republika"
/// TahunTerbit : "2006"
/// JumlahHalaman : "438"
/// Rating : 4.285714285714286
/// Total_ulasan : 7
/// JumlahRating : 30
/// JumlahPeminjam : 7
/// Status : "Popular"
/// Keterangan : "Tersimpan"

class DataBook {
  DataBook({
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
      this.status, 
      this.keterangan,});

  DataBook.fromJson(dynamic json) {
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
    keterangan = json['Keterangan'];
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
  String? keterangan;

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
    map['Keterangan'] = keterangan;
    return map;
  }

}