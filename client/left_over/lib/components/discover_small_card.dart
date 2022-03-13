import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscoverSmallCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color gradientStartColor;
  final Color gradientEndColor;
  final double height;
  final double width;
  final Widget vectorBottom;
  final Widget vectorTop;
  final double borderRadius;
  final Widget icon;
  final Function() onTap;
  const DiscoverSmallCard(
      {Key key,
      this.title,
      this.subtitle,
      this.gradientStartColor,
      this.gradientEndColor,
      this.height,
      this.width,
      this.vectorBottom,
      this.vectorTop,
      this.borderRadius,
      this.icon,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [
              gradientStartColor ?? const Color(0xff441DFC),
              gradientEndColor ?? const Color(0xff4E81EB),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Stack(
          children: [
            SizedBox(
              height: size.height * 0.05,
              width: 150,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                height: 125,
                width: 150,
                child: Stack(
                  children: const [
                    SizedBox(
                      height: 125,
                      width: 150,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 125,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 17.0,
                          color: const Color(0xffffffff).withOpacity(0.7),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18.0)),
                          TextSpan(
                            text: subtitle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
