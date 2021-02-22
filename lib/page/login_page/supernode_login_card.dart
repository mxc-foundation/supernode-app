import 'package:flutter/material.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/route.dart';

import 'shared.dart';
import 'supernode_login_page/view.dart';

class SupernodeLoginCard extends StatelessWidget {
  final Animation<double> animation;
  final VoidCallback onTap;
  final bool fixed;

  const SupernodeLoginCard({
    Key key,
    this.animation,
    this.onTap,
    this.fixed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
              Tween<double>(begin: 80, end: 20).evaluate(animation)),
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(
              Tween<double>(begin: 30, end: 20).evaluate(animation)),
          bottomLeft: Radius.circular(20),
        ),
        gradient: LinearGradient(
          colors: [
            Color(0xFF02FFD8),
            Color(0xFF1C1478),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: TweenSequence([
              TweenSequenceItem(
                tween: Tween<double>(begin: 300, end: 250),
                weight: 40.0,
              ),
              TweenSequenceItem(
                tween: Tween<double>(begin: 250, end: 60),
                weight: 60.0,
              ),
            ]).evaluate(animation),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap,
              child: LayoutBuilder(builder: (ctx, cnstr) {
                final Size biggest = cnstr.biggest;
                return Stack(
                  children: [
                    PositionedTransition(
                      rect: RelativeRectTween(
                        begin: RelativeRect.fromSize(
                          Rect.fromLTWH(biggest.width - 130 - 16, 16, 130, 130),
                          biggest,
                        ),
                        end: RelativeRect.fromSize(
                          Rect.fromLTWH(16, 15, 40, 40),
                          biggest,
                        ),
                      ).animate(animation),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Image.asset(AppImages.mxc),
                      ),
                    ),
                    PositionedTransition(
                      rect: RelativeRectTween(
                        begin: RelativeRect.fromSize(
                          Rect.fromLTWH(biggest.width - 130 - 16, 162, 130, 30),
                          biggest,
                        ),
                        end: RelativeRect.fromSize(
                          Rect.fromLTWH((biggest.width - 130) / 2, 26, 130, 30),
                          biggest,
                        ),
                      ).animate(animation),
                      child: Text(
                        'SUPERNODE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 36,
                      top: 190,
                      child: FadeTransition(
                        opacity: TweenSequence<double>([
                          TweenSequenceItem(
                            tween: Tween<double>(begin: 1, end: 0),
                            weight: 30.0,
                          ),
                          TweenSequenceItem(
                            tween: ConstantTween(0),
                            weight: 70.0,
                          ),
                        ]).animate(animation),
                        child: Text(
                          'Learn More',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    PositionedTransition(
                      rect: RelativeRectTween(
                        begin: RelativeRect.fromSize(
                          Rect.fromLTWH(biggest.width - 18 - 16, 191, 18, 18),
                          biggest,
                        ),
                        end: RelativeRect.fromSize(
                          Rect.fromLTWH(biggest.width - 40 - 16, 16, 40, 40),
                          biggest,
                        ),
                      ).animate(animation),
                      child: RotationTransition(
                        turns: Tween<double>(begin: 0, end: 0.5)
                            .animate(animation),
                        child: Icon(
                          fixed ? Icons.close : Icons.arrow_forward,
                          color: Colors.white,
                          size: Tween<double>(begin: 16, end: 40)
                              .evaluate(animation),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          Expanded(
            child: FadeTransition(
              opacity: TweenSequence<double>([
                TweenSequenceItem(
                  tween: ConstantTween(0),
                  weight: 50.0,
                ),
                TweenSequenceItem(
                  tween: Tween<double>(begin: 0, end: 1),
                  weight: 50.0,
                ),
              ]).animate(animation),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    Expanded(
                      flex: 3,
                      child: ImageWithText(
                        text: 'What is a Supernode?',
                        image: AssetImage(AppImages.mxcSite1),
                        fontSize: Tween<double>(begin: 3, end: 16)
                            .evaluate(animation),
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      flex: 3,
                      child: ImageWithText(
                        text: 'How to Become a Supernode',
                        image: AssetImage(AppImages.mxcSite2),
                        fontSize: Tween<double>(begin: 3, end: 16)
                            .evaluate(animation),
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      flex: 3,
                      child: ImageWithText(
                        text: 'Supernode Staking and Profit Sharing',
                        image: AssetImage(AppImages.mxcSite3),
                        fontSize: Tween<double>(begin: 3, end: 16)
                            .evaluate(animation),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleButton(
                text: 'Signup',
                icon: Icons.add,
              ),
              SizedBox(width: 23),
              CircleButton(
                text: 'Login',
                icon: Icons.arrow_forward,
                onPressed: () => Navigator.of(context)
                    .push(route((ctx) => SupernodeLoginPage())),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}