import 'package:amizone_clientapp/Remote/Models/attendance.dart';
import 'package:amizone_clientapp/Remote/Repositories/user_repository.dart';
import 'package:amizone_clientapp/UI/home/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:amizone_clientapp/Widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Dashborad extends StatelessWidget {
  const Dashborad({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DashboardBloc>(
      create: (context) =>
          DashboardBloc(userRepository: UserRepository.instance)
            ..add(DashboardShowed()),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardSuccess) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 0, 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Welcome user",
                        style: TextStyle(
                          fontSize: 30,
                        )),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "My Attendance",
                              style: TextStyle(fontSize: 20),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 200.0,
                                child: ListView.builder(
                                  
                                  itemCount: state.users.length,
                                  itemBuilder: (context, index) {
                                    Attendance user = state.users[index];

                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: AttendanceTile(attend: user)),
                                    );
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          if (state is DashboardFailure) {
            return Center(
              child: Column(
                children: [
                  Text(state.message),
                  RaisedButton(
                    child: Text("Retry"),
                    onPressed: () => BlocProvider.of<DashboardBloc>(context)
                        .add(DashboardShowed()),
                  )
                ],
              ),
            );
          }
          if (state is DashboardLoading) {
            return LoadingIndicator();
          } else
            return Text("an error occurred");
        },
      ),
    );
  }
}

class AttendanceTile extends StatefulWidget {
  final Attendance attend;

  AttendanceTile({Key key, @required this.attend}) : super(key: key);

  @override
  _AttendanceTileState createState() => _AttendanceTileState();
}

class _AttendanceTileState extends State<AttendanceTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      title: Text(
        widget.attend.coursename.substring(0, 7),
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.attend.coursename.substring(7).trim(),
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold)),
          Text(widget.attend.ratio)
        ],
      ),
      trailing: CircularPercentIndicator(
        animation: true,
        animationDuration: 1200,
        percent: double.parse(widget.attend.percentage.split("%")[0]) / 100.0,
        center: new Text(
          widget.attend.percentage.split("%")[0],
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        ),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: _getValuecolor(),
        radius: 51,
      ),
    );
  }

  _getValuecolor() {
    double value = double.parse(widget.attend.percentage.split("%")[0]);

    if (value > 85.0) {
      return Colors.green;
    } else if (value < 85.0 && value > 75.0) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}
