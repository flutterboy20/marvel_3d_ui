import 'package:flutter/material.dart';

class HerosCardWidget extends StatelessWidget {
  const HerosCardWidget({
    super.key,
    required this.deviceSize,
    required this.heroImage,
    required this.heroLogo,
    required this.heroName,
    required this.heroInfo,
    required this.color,
  });

  final Size deviceSize;
  final String heroImage;
  final String heroLogo;
  final String heroName;
  final String heroInfo;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceSize.width * 0.8,
      height: deviceSize.height * 0.8,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: deviceSize.width * 0.8,
              height: deviceSize.height * 0.6,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(14)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: deviceSize.height * 0.3,
                      width: deviceSize.width * 0.7,
                      child: Image.asset(
                        heroLogo,
                        fit: BoxFit.contain,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      heroName,
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
                        heroInfo,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 7,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -20,
            child: SizedBox(
              width: deviceSize.width,
              height: deviceSize.height * 0.55,
              child: Hero(
                tag: heroName,
                child: Image.asset(
                  heroImage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
