import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeBannerCarousel extends StatefulWidget {
  HomeBannerCarousel({Key? key}) : super(key: key);

  @override
  _HomeBannerCarouselState createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  int _current = 0;

  final List<Map<String, String>> itens = [
    {
      'img': 'assets/imgs/initialCarrossel1.jpg',
      'message': 'Qualidade de vida',
      'subtitle': 'Seja no campo ou na cidade, sua vida merece um bem estar!',
    },
    {
      'img': 'assets/imgs/initialCarrossel2.jpg',
      'message': 'Um projeto para cada sonho',
      'subtitle': 'Seja no campo ou na cidade, sua vida merece um bem estar!',
    },
    {
      'img': 'assets/imgs/initialCarrossel3.jpg',
      'message': 'Um Ótimo negócio',
      'subtitle': 'Seja no campo ou na cidade, sua vida merece um bem estar!',
    },
    {
      'img': 'assets/imgs/initialCarrossel4.jpeg',
      'message': 'Tenha seu próprio imóvel',
      'subtitle': 'Seja no campo ou na cidade, sua vida merece um bem estar!',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: itens.length,
          itemBuilder: (context, index, realIdx) {
            return Stack(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(1, 0, 1, 0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(0, 133, 13, 13),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      itens[index]['img']!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: 25,
                  left: 8,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.32,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itens[index]['message']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          itens[index]['subtitle']!,
                          style: TextStyle(
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          options: CarouselOptions(
            height: 125,
            enlargeCenterPage: false,
            autoPlay: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 1000),
            autoPlayInterval: Duration(seconds: 10),
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: itens.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => CarouselSlider.builder,
              child: Container(
                width: 5.0,
                height: 5.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
