import 'package:amizone_clientapp/Remote/Models/Schedule.dart';
import 'package:amizone_clientapp/UI/home/bloc/home_bloc.dart';
import 'package:amizone_clientapp/UI/home/screens/SchedulePage/SchedulePage.dart';

import 'package:amizone_clientapp/UI/home/screens/dashboard/Homedashboard.dart';
import 'package:amizone_clientapp/auth/authbloc_bloc.dart';
import 'package:amizone_clientapp/auth/authbloc_event.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
      ],
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          pageController.animateToPage(state.index,
              duration: Duration(milliseconds: 450), curve: Curves.ease);
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              Scaffold(body: Center(child: RaisedButton(
                                onPressed: () {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(LoggedOut());
                                  Navigator.of(context).pop();
                                },
                              )))),
                    ),
                  ),
                ],
                title: Text(state.toString()),
              ),
              body: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  Dashborad(),
                  SchedulePage(),
                  Scaffold(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap:
                    (index) => // This triggers when the user clicks item on BottomNavyBar
                        BlocProvider.of<HomeBloc>(context)
                            .add(HomeEvent.fromIndex(index)),
                currentIndex: state.index,
                selectedItemColor: Theme.of(context).accentColor,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text("Home"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.today),
                    title: Text("Schedule"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.assignment_late),
                    title: Text("Assignments"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
