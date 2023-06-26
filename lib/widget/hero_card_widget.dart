import 'package:flutter/material.dart';

class HerosCardWidget extends StatefulWidget {
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
  State<HerosCardWidget> createState() => _HerosCardWidgetState();
}

class _HerosCardWidgetState extends State<HerosCardWidget> {
  bool animate = true;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        animate = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: widget.key,
      width: widget.deviceSize.width * 0.8,
      height: widget.deviceSize.height * 0.8,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: widget.deviceSize.width * 0.8,
              height: widget.deviceSize.height * 0.6,
              decoration: BoxDecoration(
                  color: widget.color, borderRadius: BorderRadius.circular(14)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: widget.deviceSize.height * 0.3,
                      width: widget.deviceSize.width * 0.7,
                      child: Image.asset(
                        widget.heroLogo,
                        fit: BoxFit.contain,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      widget.heroName,
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
                        widget.heroInfo,
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
          AnimatedPositioned(
            curve: Curves.easeIn,
            top: -20,
            left: animate ? 50 : 0,
            duration: const Duration(milliseconds: 200),
            child: SizedBox(
              width: widget.deviceSize.width,
              height: widget.deviceSize.height * 0.55,
              child: Hero(
                tag: widget.heroName,
                child: Image.asset(
                  widget.heroImage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TranslateHero extends StatefulWidget {
  const TranslateHero({super.key, required this.child});
  final Widget? child;

  @override
  State<TranslateHero> createState() => _TranslateHeroState();
}

class _TranslateHeroState extends State<TranslateHero>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this)
          ..addListener(() => setState(() {}));
    animation = Tween(begin: 200.0, end: 0.0).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: Offset(controller.value, 0),
        child: widget.child ?? Container());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
