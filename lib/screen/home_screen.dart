import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/heros_model.dart';
import '../widget/hero_card_widget.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HeroModal> heroes = [];
  List<Color> colors = [Colors.indigo, Colors.red, Colors.amber];

  @override
  void initState() {
    loadHeroes();
    super.initState();
  }

  //To load and decode the json file from assets
  Future<void> loadHeroes() async {
    String jsonData =
        await rootBundle.loadString('assets/json/heros_info.json');
    List<dynamic> data = json.decode(jsonData)['heroes'];
    List<HeroModal> heroList =
        data.map((hero) => HeroModal.fromJson(hero)).toList();
    setState(() {
      heroes = heroList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 14, top: 12),
              child: Text(
                "MARVEL",
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 0),
              child: Text(
                "Super Heros",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Center(
              child: SizedBox(
                width: deviceSize.width,
                height: deviceSize.height * 0.8,
                child: CarouselSlider.builder(
                    options: CarouselOptions(
                      viewportFraction: 0.8,
                      initialPage: 1,
                      reverse: false,
                      autoPlay: false,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      disableCenter: true,
                      enlargeFactor: 0.3,
                    ),
                    itemCount: heroes.length,
                    itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) {
                      final hero = heroes[itemIndex];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                color: colors[itemIndex],
                                hero: hero,
                              ),
                            ),
                          );
                        },
                        child: HerosCardWidget(
                          deviceSize: deviceSize,
                          heroImage: hero.heroImage,
                          heroLogo: hero.heroLogo,
                          heroInfo: hero.heroInfo,
                          heroName: hero.heroName,
                          color: colors[itemIndex],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}