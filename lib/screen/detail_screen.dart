import 'package:flutter/material.dart';
import '../model/heros_model.dart';

class DetailScreen extends StatelessWidget {
  final Color color;
  final HeroModal hero;
  const DetailScreen({Key? key, required this.color, required this.hero})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        elevation: 0,
      ),
      backgroundColor: color,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: deviceSize.width,
            height: deviceSize.height * 0.4,
            child: Hero(
              tag: hero.heroName,
              child: Image.asset(
                hero.heroImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            hero.heroName,
            style: const TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              hero.heroInfo,
              overflow: TextOverflow.ellipsis,
              maxLines: 7,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: DraggableScrollableSheet(
              initialChildSize: 0.8,
              maxChildSize: 1,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 14.0, top: 8),
                          child: Text(
                            "Latest News",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: hero.heroLatestNews.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 250,
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        hero.heroLatestNews[index],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 14.0, top: 8),
                          child: Text(
                            "Related Movies",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: hero.heroLatestNews.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 150,
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        hero.relatedMovies[index],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
