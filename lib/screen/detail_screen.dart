import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import '../model/heros_model.dart';

class DetailScreen extends StatefulWidget {
  final Color color;
  final HeroModal hero;
  const DetailScreen({Key? key, required this.color, required this.hero})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool animate = false;

  bool reverseScroll = false;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        animate = true;
      });
    }).then(
      (value) {
        setState(() {
          reverseScroll = true;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        elevation: 0,
      ),
      backgroundColor: widget.color,
      body: Stack(
        children: [
          Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: deviceSize.height * 0.4,
                  ),
                  Text(
                    widget.hero.heroName,
                    style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      widget.hero.heroInfo,
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
                ],
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 320),
                top: animate ? 0 : -300,
                curve: Curves.fastOutSlowIn,
                child: SizedBox(
                  width: deviceSize.width,
                  height: deviceSize.height * 0.4,
                  child: Image.asset(
                    widget.hero.heroImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          customDraggableSheet()
        ],
      ),
    );
  }

  Widget customDraggableSheet() {
    final hight = MediaQuery.sizeOf(context).height;
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        height: reverseScroll ? hight * 0.60 : hight * 0.24,
        curve: Curves.easeInOutBack,
        duration: const Duration(milliseconds: 1500),
        child: Material(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              SchedulerBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    if (direction == ScrollDirection.reverse &&
                        notification.metrics.axis == Axis.vertical) {
                      reverseScroll = true;
                    } else if (direction == ScrollDirection.forward &&
                        notification.metrics.axis == Axis.vertical) {
                      reverseScroll = false;
                    }
                  });
                }
              });

              return true;
            },
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 14.0, top: 14),
                    child: Text(
                      "Latest News",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: hight * 0.20,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.hero.heroLatestNews.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 250,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(
                                  widget.hero.heroLatestNews[index],
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
                    height: hight * 0.30,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.hero.heroLatestNews.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 150,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage(
                                  widget.hero.relatedMovies[index],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                  ),
                  Container(
                    height: hight * 0.03,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
