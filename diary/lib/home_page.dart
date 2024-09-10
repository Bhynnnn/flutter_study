import 'package:diary/diary_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();
  TextEditingController createTextController = TextEditingController();
  TextEditingController updateTextController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initializeDateFormatting(Localizations.localeOf(context).languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryService>(
      builder: (context, diaryService, child) {
        List<Diary> diaryList = diaryService.getByDate(selectedDate);
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
                    todayDecoration: BoxDecoration(color: Colors.transparent),
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
                  eventLoader: (date) {
                    return diaryService.getByDate(date);
                  },
                ),
                Divider(
                  color: Colors.grey.shade200,
                ),
                Expanded(
                  child: diaryList.isEmpty
                      ? Text(
                          '아무것도 없어요',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        )
                      : ListView.builder(
                          itemCount: diaryList.length,
                          itemBuilder: (context, index) {
                            Diary diary = diaryList[index];
                            return GestureDetector(
                              onTap: () {
                                // 수정
                                showUpdateDialog(diaryService, diary);
                              },
                              onLongPress: () {
                                showDeleteDialog(diaryService, diary);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    diary.text,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    DateFormat('kk:mm').format(diary.createdAt),
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showCreateDialog(diaryService);
            },
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

  void createDiary(DiaryService diaryService) {
    String newText = createTextController.text.trim();
    if (newText.isNotEmpty) {
      diaryService.create(newText, selectedDate);
      createTextController.text = "";
    }
  }

  void updateDiary(DiaryService diaryService, Diary diary) {
    String updateText = updateTextController.text.trim();
    if (updateText.isNotEmpty) {
      diaryService.update(diary.createdAt, updateText);
    }
  }

  void showUpdateDialog(DiaryService diaryService, Diary diary) {
    showDialog(
        context: context,
        builder: (context) {
          updateTextController.text = diary.text;
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            title: Text(
              '일기 수정',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            content: TextField(
              controller: updateTextController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: '한 줄 일기를 작성해주세요.',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo),
                ),
              ),
              onSubmitted: (_) {
                updateDiary(diaryService, diary);
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  updateDiary(diaryService, diary);
                  Navigator.pop(context);
                },
                child: Text('수정'),
              ),
            ],
          );
        });
  }

  void showCreateDialog(DiaryService diaryService) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            title: Text(
              '일기 작성',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            content: TextField(
              controller: createTextController,
              autofocus: true,
              decoration: InputDecoration(hintText: '한 줄 일기를 작성해주세요.'),
              onSubmitted: (_) {
                createDiary(diaryService);
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  createDiary(diaryService);
                  Navigator.pop(context);
                },
                child: Text('작성'),
              ),
            ],
          );
        });
  }

  void showDeleteDialog(DiaryService diaryService, Diary diary) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('일기를 삭제하시겠습니까'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  diaryService.delete(diary.createdAt);
                  Navigator.pop(context);
                },
                child: Text('삭제'),
              ),
            ],
          );
        });
  }
}
