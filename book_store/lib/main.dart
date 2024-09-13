import 'package:book_store/book.dart';
import 'package:book_store/book_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => BookService()),
    ],
    child: const MyWidget(),
  ));
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController searchTextController = TextEditingController();

  void search(BookService bookService) {
    String keyword = searchTextController.text;
    if (keyword.isNotEmpty) {
      bookService.getBookList(keyword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookService>(builder: (context, bookService, child) {
      var totalItem = bookService.bookList.length;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          elevation: 0,
          title: Text(
            "Book Store",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          actions: [
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(
                right: 8,
              ),
              child: Text("total $totalItem"),
            )
          ],
          centerTitle: false,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                  hintText: '원하시는 책을 검색해주세요',
                  focusColor: Colors.blue.shade200,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blue.shade200, width: 1.5),
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
                onSubmitted: (_) {
                  search(bookService);
                  // 검색 버튼 눌렀어 -> 검색돼야겠지
                },
              ),
            ),
          ),
        ),
        body: bookService.bookList.isEmpty
            ? Center(
                child: Text(
                  "검색어를 입력해 주세요",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              )
            : ListView.builder(
                itemCount: bookService.bookList.length,
                itemBuilder: (context, index) {
                  Book book = bookService.bookList[index];
                  return ListTile(
                    leading: Image.network(
                      book.thumbnail,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    title: Text(book.title),
                    subtitle: Text(book.subtitle),
                    onTap: () {
                      print(book.previewLink);
                      Uri uri = Uri.parse(book.previewLink);
                      launchUrl(uri);
                    },
                  );
                },
              ),
      );
    });
  }
}
