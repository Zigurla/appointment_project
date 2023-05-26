import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void  main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Randevu Projesi",
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('tr'),
      ],
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {



  /// Varsayılan Tarih Değişkeni
  DateTime defaultDate = DateTime.now();
  TimeOfDay defaultTime = TimeOfDay.now();
  TextEditingController isimController = TextEditingController();


  /// Tablodan tıklayınca bu değişkene atılıyo tarih değeri
  late CalendarController tablocontroller;



  /// Direkt Tablo Üzerinden Dokunma Fonksiyonu
  void handleTap(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.calendarCell) {
      final DateTime? date = details.date;
      print('Seçilen tarih: $date');
      showDialog(context: context, builder: (context)=> AlertDialog(
          title: Container(
            margin: EdgeInsets.all(25),
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width/2,
            child: Column(
              children: [
                Text(date.toString())
              ],
            ),
          )
      ));
    }
  }

  List<Appointment> meetings = <Appointment>[];


  /// Date Picker
  Future<DateTime?> datePicker () async{
    final dateTime = await showDatePicker(
        context: context,
        initialDate: defaultDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    return dateTime;

  }

  /// Time Picker
  Future<TimeOfDay?> timePicker()async{
    final time = await showTimePicker(
        context: context, initialTime: defaultTime);
    return time;
  }


  kaydetme()async{
    setState(() {
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// SAĞ ALTTAKİ + BUTONU
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState){
                          return Container(
                            height: MediaQuery.of(context).size.height/2,
                            width: MediaQuery.of(context).size.width/2,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [

                                      /// İSİM
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text("İsim"),
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey),
                                                color: Colors.grey[200],
                                                borderRadius: BorderRadius.all(Radius.circular(15))
                                            ),
                                            height: 50,
                                            width: MediaQuery.of(context).size.width/4,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 10.0),
                                              child: TextField(
                                                controller: isimController,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15,),


                                      Container(
                                        color: Colors.transparent,
                                        width: MediaQuery.of(context).size.width/4,
                                        height: 100,
                                        child: Row(
                                          children: [

                                            /// TARİH
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8.0),
                                                    child: Text("Tarih"),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async{
                                                      /// ON TAP
                                                      final datedate = await datePicker();
                                                      if(datedate != null){
                                                        setState((){
                                                          defaultDate = datedate;
                                                        });
                                                      }

                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.only(right: 5),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.grey),
                                                          color: Colors.grey[200],
                                                          borderRadius: BorderRadius.all(Radius.circular(15))
                                                      ),
                                                      height: 50,
                                                      child: Center(child: Text("${defaultDate.year}/${defaultDate.month}/${defaultDate.day}"),),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),


                                            /// SAAT
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8.0),
                                                    child: Text("Saat"),
                                                  ),
                                                  GestureDetector(
                                                    onTap: ()async{
                                                      /// ON TAP

                                                      final TimeOfDay? timetime = await timePicker();

                                                      if(timetime != null){
                                                        setState(() {
                                                          defaultTime = timetime;
                                                        });
                                                      }

                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.grey),
                                                          color: Colors.grey[200],
                                                          borderRadius: BorderRadius.all(Radius.circular(15))
                                                      ),
                                                      height: 50,
                                                      child: Center(child: Text("${defaultTime.format(context)}"),),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),


                                ElevatedButton(
                                    onPressed: ()async{
                                      final DateTime startTime = DateTime(defaultDate.year, defaultDate.month, defaultDate.day, defaultTime.hour, defaultTime.minute);
                                      final DateTime endTime = startTime.add(const Duration(hours: 1));

                                      meetings.add(await Appointment(
                                          startTime: startTime,
                                          endTime: endTime,
                                          subject: isimController.text,
                                          color: startTime.isBefore(DateTime.now()) ? Colors.red : Colors.blue,
                                          recurrenceRule: 'FREQ=DAILY;COUNT=1',
                                          isAllDay: false,

                                      ));
                                      kaydetme();
                                    },
                                    child: Text("Kaydet"))

                              ],
                            ),
                          );
                        }
                    )
                  );
                }
            );
          },
          child: Icon(Icons.add),
        ),

      body: SfCalendar(
        onTap: handleTap,
        //controller: tablocontroller,
        view: CalendarView.week,
        firstDayOfWeek: 1,
        showDatePickerButton: true,
        showNavigationArrow: true,
        resourceViewSettings: ResourceViewSettings(
          size: 100,
        ),
        timeSlotViewSettings: TimeSlotViewSettings(
          timeFormat: 'H:mm',
          startHour: 0,


        ),
        dataSource: MeetingDataSource(meetings),
        appointmentBuilder: (BuildContext context, CalendarAppointmentDetails details){
          final Appointment ap = details.appointments.first;
          return GestureDetector(
            onTap: (){},
            child: Container(
              decoration: BoxDecoration(
                color: ap.color,
                borderRadius: BorderRadius.circular(8),
              ),
                  child: Column(
                    children: [
                      Text(ap.subject)
                    ],
                  ),
            ),
          );
        },
      ),
    );
  }
}



class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}