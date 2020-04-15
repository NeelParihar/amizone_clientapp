import 'package:amizone_clientapp/Remote/Models/Schedule.dart';
import 'package:amizone_clientapp/Remote/Repositories/user_repository.dart';
import 'package:amizone_clientapp/UI/home/screens/SchedulePage/bloc/schedule_bloc.dart';
import 'package:amizone_clientapp/Widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScheduleBloc>(
      create: (context) => ScheduleBloc(userRepository: UserRepository.instance)
        ..add(ScheduleShowed()),
      child: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (context, state) {
          if (state is ScheduleSuccess) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "My Schedule",
                              style: TextStyle(fontSize: 20),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.users.length,
                                itemBuilder: (context, index) {
                                  Schedule user = state.users[index];

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

          if (state is ScheduleFailure) {
            return Center(
              child: Column(
                children: [
                  Text(state.message),
                  RaisedButton(
                    child: Text("Retry"),
                    onPressed: () => BlocProvider.of<ScheduleBloc>(context)
                        .add(ScheduleShowed()),
                  )
                ],
              ),
            );
          }
          if (state is ScheduleLoading) {
            return LoadingIndicator();
          } else
            return Text("an error occurred");
        },
      ),
    );
  }
}

class AttendanceTile extends StatefulWidget {
  final Schedule attend;

  AttendanceTile({Key key, @required this.attend}) : super(key: key);

  @override
  _AttendanceTileState createState() => _AttendanceTileState();
}

class _AttendanceTileState extends State<AttendanceTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ListTile(
        isThreeLine: true,
        title: Text(
          widget.attend.coursename.substring(0, 13),
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.attend.coursename.substring(21),
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold)),
            Text(widget.attend.profname)
          ],
        ),
        trailing: Text(widget.attend.coursename.substring(13, 20)),
      ),
    );
  }
}
