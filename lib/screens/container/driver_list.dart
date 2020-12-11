// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shipanther/bloc/container/container_bloc.dart';
// import 'package:shipanther/helper/text_widget.dart';
// import 'package:shipanther/l10n/shipanther_localization.dart';

// import 'package:shipanther/widgets/shipanther_scaffold.dart';
// import 'package:trober_sdk/api.dart' as api;
// import 'package:shipanther/extensions/container_extension.dart';

// class DriverContainerList extends StatefulWidget {
//   final ContainerBloc containerBloc;
//   final ContainersLoaded containerLoadedState;
//   final api.User loggedInUser;
//   const DriverContainerList(
//     this.loggedInUser, {
//     Key key,
//     @required this.containerLoadedState,
//     @required this.containerBloc,
//   }) : super(key: key);

//   @override
//   _DriverContainerListState createState() => _DriverContainerListState();
// }

// class _DriverContainerListState extends State<DriverContainerList> {
//   int _currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     void onTabTapped(int index) {
//       setState(() {
//         _currentIndex = index;
//       });
//     }

//     var title = ShipantherLocalizations.of(context).containersTitle;
//     List<Widget> actions = [];
//     var totalPending = widget.containerLoadedState.containers
//         .where((element) => element.status == api.ContainerStatus.accepted)
//         .length;
//     var items = _currentIndex == 0
//         ? widget.containerLoadedState.containers.where((element) =>
//             element.status == api.ContainerStatus.accepted ||
//             element.status == api.ContainerStatus.assigned)
//         : widget.containerLoadedState.containers
//             .where((element) => element.status == api.ContainerStatus.arrived);

//     Widget body = items.length == 0
//         ? Center(child: Text("No items here"))
//         : ListView.builder(
//             itemCount: items.length,
//             itemBuilder: (BuildContext context, int index) {
//               var t = items.elementAt(index);
//               return Column(
//                 children: [
//                   ExpansionTile(
//                     leading: Icon(Icons.home_work),
//                     trailing: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           DateFormat('dd-MM-yyyy').format(
//                               t.reservationTime == null
//                                   ? DateTime.now()
//                                   : t.reservationTime),
//                           style: TextStyle(
//                               fontSize: 15,
//                               color: Color.fromRGBO(204, 255, 0, 1)),
//                         ),
//                         Text(
//                           DateFormat('kk:mm').format(t.reservationTime == null
//                               ? DateTime.now()
//                               : t.reservationTime),
//                           style: TextStyle(fontSize: 15),
//                         ),
//                       ],
//                     ),
//                     title: Text(
//                       t.serialNumber,
//                       style: TextStyle(color: t.status.color, fontSize: 20),
//                     ),
//                     subtitle: Text('${t.origin} to ${t.destination}'),
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [textSpan('Size: ', t.size.text)],
//                       ),
//                       t.status == api.ContainerStatus.accepted
//                           ? FlatButton(
//                               color: Colors.green,
//                               onPressed: () {
//                                 t.status = api.ContainerStatus.arrived;
//                                 widget.containerBloc
//                                     .add(UpdateContainer(t.id, t));
//                               },
//                               child: Text('Delivered'),
//                             )
//                           : Container(
//                               width: 0,
//                               height: 0,
//                             ),
//                     ],
//                   ),
//                   t.status == api.ContainerStatus.assigned
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             FlatButton(
//                               color: Colors.green,
//                               onPressed: () {
//                                 t.status = api.ContainerStatus.accepted;
//                                 widget.containerBloc
//                                     .add(UpdateContainer(t.id, t));
//                               },
//                               child: Text(
//                                 'Accept',
//                               ),
//                             ),
//                             FlatButton(
//                               color: Colors.red,
//                               onPressed: () {
//                                 //TODO:Add Confirmation prompt
//                                 t.status = api.ContainerStatus.rejected;
//                                 t.driverId = null;
//                                 widget.containerBloc
//                                     .add(UpdateContainer(t.id, t));
//                               },
//                               child: Text(
//                                 'Reject',
//                               ),
//                             )
//                           ],
//                         )
//                       : Container(
//                           width: 0,
//                           height: 0,
//                         ),
//                 ],
//               );
//             },
//           );
//     Widget bottomNavigationBar = BottomNavigationBar(
//       backgroundColor: Colors.white10,
//       currentIndex: _currentIndex,
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: Colors.white,
//       unselectedItemColor: Colors.white.withOpacity(.60),
//       selectedFontSize: 14,
//       unselectedFontSize: 14,
//       elevation: 1,
//       onTap: onTabTapped,
//       items: [
//         BottomNavigationBarItem(
//           label: 'Pending',
//           icon: new Stack(
//             children: <Widget>[
//               new Icon(Icons.pending),
//               new Positioned(
//                 right: 0,
//                 child: new Container(
//                   padding: EdgeInsets.all(1),
//                   decoration: new BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   constraints: BoxConstraints(
//                     minWidth: 13,
//                     minHeight: 13,
//                   ),
//                   child: new Text(
//                     totalPending.toString(),
//                     style: new TextStyle(
//                       color: Colors.white,
//                       fontSize: 8,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//         BottomNavigationBarItem(
//           label: 'Completed',
//           icon: Icon(
//             Icons.check,
//             color: Colors.green,
//           ),
//         ),
//       ],
//     );

//     return ShipantherScaffold(
//       widget.loggedInUser,
//       bottomNavigationBar: bottomNavigationBar,
//       title: title,
//       actions: actions,
//       body: body,
//       floatingActionButton: null,
//     );
//   }
// }

//TODO:remover

// import 'package:flutter/material.dart';

// class ExampleWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Widget bigCircle = new Container(
//       width: 300.0,
//       height: 300.0,
//       decoration: new BoxDecoration(
//         color: Colors.orange,
//         shape: BoxShape.circle,
//       ),
//     );
//     Widget smallCircle = new Container(
//       width: 200.0,
//       height: 200.0,
//       decoration: new BoxDecoration(
//         color: Colors.red,
//         shape: BoxShape.circle,
//       ),
//     );

//     return new Material(
//       color: Colors.black,
//       child: new Center(
//         child: new Stack(
//           children: <Widget>[
//             bigCircle,
//             new Positioned(
//               child: smallCircle,
//               top: 50.0,
//               left: 50.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CircleButton extends StatelessWidget {
//   final GestureTapCallback onTap;
//   final IconData iconData;

//   const CircleButton({Key key, this.onTap, this.iconData}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double size = 50.0;

//     return new InkResponse(
//       onTap: onTap,
//       child: new Container(
//         width: size,
//         height: size,
//         decoration: new BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//         ),
//         child: new Icon(
//           iconData,
//           color: Colors.black,
//         ),
//       ),
//     );
//   }
// }

// import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Circular Percent Indicators"),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            // new CircularPercentIndicator(
            //   radius: 100.0,
            //   lineWidth: 10.0,
            //   percent: 0.8,
            //   header: new Text("Icon header"),
            //   center: new Icon(
            //     Icons.person_pin,
            //     size: 50.0,
            //     color: Colors.blue,
            //   ),
            //   backgroundColor: Colors.grey,
            //   progressColor: Colors.blue,
            // ),
            // new CircularPercentIndicator(
            //   radius: 130.0,
            //   animation: true,
            //   animationDuration: 1200,
            //   lineWidth: 15.0,
            //   percent: 0.4,
            //   center: new Text(
            //     "40 hours",
            //     style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            //   ),
            //   circularStrokeCap: CircularStrokeCap.butt,
            //   backgroundColor: Colors.yellow,
            //   progressColor: Colors.red,
            // ),
            // new CircularPercentIndicator(
            //   radius: 120.0,
            //   lineWidth: 13.0,
            //   animation: true,
            //   percent: 0.7,
            //   center: new Text(
            //     "70.0%",
            //     style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            //   ),
            //   footer: new Text(
            //     "Sales this week",
            //     style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            //   ),
            //   circularStrokeCap: CircularStrokeCap.round,
            //   progressColor: Colors.purple,
            // ),
            // Padding(
            //   padding: EdgeInsets.all(15.0),
            //   child: new CircularPercentIndicator(
            //     radius: 60.0,
            //     lineWidth: 5.0,
            //     percent: 1.0,
            //     center: new Text("100%"),
            //     progressColor: Colors.green,
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.all(15.0),
            //   child: new Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       new CircularPercentIndicator(
            //         radius: 45.0,
            //         lineWidth: 4.0,
            //         percent: 0.10,
            //         center: new Text("10%"),
            //         progressColor: Colors.red,
            //       ),
            //       new Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 10.0),
            //       ),
            //       new CircularPercentIndicator(
            //         radius: 45.0,
            //         lineWidth: 4.0,
            //         percent: 0.30,
            //         center: new Text("30%"),
            //         progressColor: Colors.orange,
            //       ),
            //       new Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 10.0),
            //       ),
            //       new CircularPercentIndicator(
            //         radius: 45.0,
            //         lineWidth: 4.0,
            //         percent: 0.60,
            //         center: new Text("60%"),
            //         progressColor: Colors.yellow,
            //       ),
            //       new Padding(
            //         padding: EdgeInsets.symmetric(horizontal: 10.0),
            //       ),
            new CircularPercentIndicator(
              radius: 45.0,
              lineWidth: 4.0,
              percent: 0.50,
              center: new Text("90%"),
              progressColor: Colors.green,
            )
          ],
        ),
      ),
    );
    //     ]),
    //   ),
    // );
  }
}

// class MakeCircle extends CustomPainter {
//   final double strokeWidth;
//   final StrokeCap strokeCap;

//   MakeCircle({this.strokeCap = StrokeCap.square, this.strokeWidth = 10.0});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blue
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke; //important set stroke style

//     final path = Path()
//       ..moveTo(strokeWidth, strokeWidth)
//       ..arcToPoint(Offset(size.width - strokeWidth, size.height - strokeWidth),
//           radius: Radius.circular(math.max(size.width, size.height)));

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
// class TimerPainter extends CustomPainter {
//   TimerPainter({
//     this.animation,
//     this.backgroundColor,
//     this.color,
//   }) : super(repaint: animation);

//   final Animation<double> animation;
//   final Color backgroundColor, color;

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = backgroundColor
//       ..strokeWidth = 20.0
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.stroke;

//     canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
//     paint.color = color;
//     double progress = (1.0 - animation.value) * 2 * math.pi;
//     canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
//   }

//   @override
//   bool shouldRepaint(TimerPainter old) {
//     return animation.value != old.animation.value ||
//         color != old.color ||
//         backgroundColor != old.backgroundColor;
//   }
// }
