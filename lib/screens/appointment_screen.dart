import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../constants.dart';
import '../widgets/custom_textfieldform.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  CalendarController _calendarController = CalendarController();

  @override
  initState() {
    _calendarController.displayDate = DateTime.now();
    super.initState();
  }

  String? selectedDate;
  String? _selectedFromTime;
  String? _selectedToTime;
  TimeOfDay? selectedTime;

  Future<TimeOfDay?> displayTimeDialog(helpText) async {
    TimeOfDay? time;

    time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: helpText,
    );
    if (time != null) {
      // selectedTime = time.format(context);
      print(selectedTime);
    }
    setState(() {});
    return time;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController description = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Approvement Form",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "Interview Date",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: kBlue),
                    borderRadius: BorderRadius.circular(10)),
                height: MediaQuery.of(context).size.height * 0.5,
                width: (MediaQuery.of(context).size.width * 0.8) - 1,
                child: SfCalendar(
                  view: CalendarView.month,
                  showNavigationArrow: true,
                  controller: _calendarController,
                  initialSelectedDate: DateTime.now(),
                  minDate: DateTime.now(),
                  selectionDecoration:
                      BoxDecoration(border: Border.all(color: kBlue, width: 3)),
                  timeZone: 'Central America Standard Time',
                  onTap: (calendarTapDetails) {
                    setState(() {
                      // selectedDate = DateFormat.yMMMMEEEEd()
                      //     .format(calendarTapDetails.date!);

                      _calendarController.displayDate = calendarTapDetails.date;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Selected Date: ',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  Text(
                    "${_calendarController.displayDate!.day} / ${_calendarController.displayDate!.month} / ${_calendarController.displayDate!.year}",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          displayTimeDialog('From').then((value) =>
                              {_selectedFromTime = value?.format(context)});
                        });
                      },
                      child: Text('from')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(_selectedFromTime != null
                      ? "$_selectedFromTime"
                      : "Any Time"),
                  SizedBox(
                    width: 35,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          displayTimeDialog('To').then((value) =>
                              {_selectedToTime = value?.format(context)});
                        });
                      },
                      child: Text('to')),
                  SizedBox(
                    width: 10,
                  ),
                  Text(_selectedToTime != null
                      ? "$_selectedToTime"
                      : "Any Time"),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              SizedBox(
                width: 500,
                child: CustomTextField(
                  label: "Approve description",
                  hint:
                      "Enter approve description and interview description (e.g. Congratulations!! our company approved you, you have only one step to be our employee)",
                  maxLines: 10,
                  controller: description,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Send"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
