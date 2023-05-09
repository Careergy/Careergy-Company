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

  @override
  Widget build(BuildContext context) {
    String? selectedDate;
    String? _selectedFromTime = TimeOfDay.now().format(context);
    String? _selectedToTime = TimeOfDay.now().format(context);

    displayTimeDialog(selectedTime) {
      final TimeOfDay? time = TimeOfDay.now();
      showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (time != null) {
        setState(() {
          selectedTime = time.format(context);
          print(selectedTime);
        });
      }
      return selectedTime;
    }

    TextEditingController description = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Approvement Form",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    "Interview Date",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                const SizedBox(
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
                    selectionDecoration: BoxDecoration(
                        border: Border.all(color: kBlue, width: 3)),
                    timeZone: 'Central America Standard Time',
                    onTap: (calendarTapDetails) {
                      setState(() {
                        // selectedDate = DateFormat.yMMMMEEEEd()
                        //     .format(calendarTapDetails.date!);

                        _calendarController.displayDate =
                            calendarTapDetails.date;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      'Selected Date: ',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 35,
                    ),
                    Text(
                      "${_calendarController.displayDate!.day} / ${_calendarController.displayDate!.month} / ${_calendarController.displayDate!.year}",
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      width: 35,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedFromTime =
                                displayTimeDialog(_selectedFromTime);
                          });
                        },
                        child: const Text('from')),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(_selectedFromTime!),
                    const SizedBox(
                      width: 35,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            displayTimeDialog(_selectedToTime);
                          });
                        },
                        child: const Text('to')),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(_selectedToTime),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
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
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Send"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
