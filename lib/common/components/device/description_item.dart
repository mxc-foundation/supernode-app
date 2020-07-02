import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';

class DescriptionItem extends StatelessWidget {
  final String title;
  final String content;
  final Widget titleTrackWidget;
  final Widget contentTrackWidget;

  const DescriptionItem(
      {Key key,
      this.title,
      this.content,
      this.titleTrackWidget,
      this.contentTrackWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 18),
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  title ?? "",
                  style: kMiddleFontOfBlack,
                ),
              ),
              titleTrackWidget == null ? SizedBox() : titleTrackWidget,
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  content ?? "",
                  style: kMiddleFontOfGrey,
                ),
              ),
              contentTrackWidget == null ? SizedBox() : contentTrackWidget,
            ],
          )
        ],
      ),
    );
  }
}
