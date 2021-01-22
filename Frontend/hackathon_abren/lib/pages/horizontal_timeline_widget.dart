import 'package:flutter/material.dart';
import 'dart:math';

class HorizontalTimelineWidget extends StatefulWidget {
  final List pathPoints;

  HorizontalTimelineWidget({Key key, this.pathPoints}) : super(key: key);
  @override
  _HorizontalTimelineWidgetState createState() =>
      _HorizontalTimelineWidgetState();
}

class _HorizontalTimelineWidgetState extends State<HorizontalTimelineWidget> {
  //TODO: Adjust size according to list size, try alternating directions
  List<Widget> timeline;
  List<Widget> timelineText;

  void buildTimeline() {
    timeline = new List();
    timelineText = new List();

    for (int i = 0; i < widget.pathPoints.length; i++) {
      if (i == 0) {
        timeline.add(Icon(
          Icons.my_location,
          color: Theme.of(context).accentColor,
        ));
      } else if (i == widget.pathPoints.length - 1) {
        timeline.add(Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Icon(
            Icons.location_on,
            color: Theme.of(context).primaryColor,
          ),
        ));
      } else {
        timeline.add(Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            )));
      }

      timelineText.add(Transform.rotate(
        angle: -pi / 3,
        child: Container(
          width: 60,
          height: 30,
          child: Row(
            children: <Widget>[
              Container(
                width: 60,
                child: Text(
                  widget.pathPoints[i],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
//                    fontWeight: i == 0 || i == widget.pathPoints.length - 1 ? FontWeight.bold : FontWeight.normal,
//                    color: i == 0 ? Theme.of(context).accentColor : i == widget.pathPoints.length - 1 ? Theme.of(context).primaryColor : Colors.black54
                  ),
                ),
              ),
            ],
          ),
        ),
      ));

      if (i != widget.pathPoints.length - 1) {
        timeline.add(Container(
            height: 3.0,
            width: 47.0,
            color: Colors.black26,
            ));

        timelineText.add(Container(
          color: Colors.transparent,
          height: 3.0,
          width: 3.0,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    buildTimeline();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: timelineText,
          ),
          SizedBox(height: 10),
          Row(
            children: timeline,
          ),
        ],
      ),
    );
  }
}
