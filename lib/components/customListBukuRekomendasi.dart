import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListRekomendasiBuku extends StatelessWidget {
  final context;

  CustomListRekomendasiBuku({
    super.key,
    required this.context,
  });

  List<CardItem> items = [
    CardItem(
      imageURl: "assets/images/buku/buku1.png",
      judulBuku: "Laskar Pelangi",
    ),
    CardItem(
      imageURl: "assets/images/buku/buku2.png",
      judulBuku: "Bung Karno",
    ),
    CardItem(
      imageURl: "assets/images/buku/buku3.png",
      judulBuku: "Kisah Tanah Jawa",
    ),
    CardItem(
      imageURl: "assets/images/buku/buku4.png",
      judulBuku: "Senja",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount : 4,
        separatorBuilder: (context, _) => SizedBox(width: 10,),
        itemBuilder: (context, index) => builCard(items:items[index]),
      ),
    );
  }

  Widget builCard({
    required CardItem items,
})=> Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.asset(
                items.imageURl,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5,),
        AutoSizeText(
          items.judulBuku,
          maxLines: 2,
          maxFontSize: 16,
          minFontSize: 12,
          style: GoogleFonts.abhayaLibre(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        )
      ],
    ),
  );
}

class CardItem {
  final String imageURl;
  final String judulBuku;

  const CardItem({
    required this.imageURl,
    required this.judulBuku,
});
}
