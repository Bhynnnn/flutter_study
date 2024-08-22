import 'package:diary/diary_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initializeDateFormatting(Localizations.localeOf(context).languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryService>(
      builder: (context, diaryService, child) {
        List<Diary> diaryList = diaryService.diaryList;
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                TableCalendar(
                  focusedDay: selectedDate,
                  firstDay: DateTime.utc(2023, 1, 1),
                  lastDay: DateTime.utc(2025, 12, 31),
                  headerStyle: HeaderStyle(
                    formatButtonTextStyle: TextStyle(color: Colors.black),
                    formatButtonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.black),
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.black,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Colors.indigo,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(color: Colors.white),
                    todayTextStyle: TextStyle(color: Colors.black),
                  ),
                  selectedDayPredicate: (day) {
                    return isSameDay(selectedDate, day);
                  },
                  onDaySelected: (_, focusedDate) {
                    setState(() {
                      selectedDate = focusedDate;
                    });
                  },
                ),
                Divider(
                  color: Colors.grey.shade200,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    itemCount: diaryList.length,
                    itemBuilder: (context, index) {
                      Diary diary = diaryList[index];
                      return Row(
                        children: diaryList.isEmpty
                            ? [Text('아무것도 없어요')]
                            : [
                                Text(
                                  diary.text,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  diary.createdAt.toString(),
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                )
                              ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.indigo,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(52)),
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
