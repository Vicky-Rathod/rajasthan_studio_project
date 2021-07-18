import 'package:floating_navbar/floating_navbar.dart';
import 'package:floating_navbar/floating_navbar_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rajasthan_studios/appointment.dart';
import 'package:rajasthan_studios/coachlist.dart';


class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin{

  static const headerAniInterval = Interval(.1, .3, curve: Curves.easeOut);
  AnimationController? _loadingController;

  @override
  void initState() {
    super.initState();

    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1250),
    );


  }



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(


        body: FloatingNavBar(
          color: theme.primaryColor,
          items: [
            FloatingNavBarItem(
              iconData: Icons.home,
              title: 'Home',
              page: CoachList(),
            ),
            FloatingNavBarItem(
              iconData: Icons.assignment_outlined,
              title: 'Service Logs',
              page: AppointmentList(),
            ),

          ],
          selectedIconColor: Colors.white,
          hapticFeedback: true,
          horizontalPadding: 40,

        ),
      ),
    );
  }
}



