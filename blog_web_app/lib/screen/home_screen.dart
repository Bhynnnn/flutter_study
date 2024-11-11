import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget {
  WebViewController webViewController = WebViewController()
    // JavaScriptMode.unrestricted 입력 시 웹페이지에서 제한없이 JavaScript가 실행될 수 있도록 함
    // 반대는 JavaScriptMode.restricted
    // loadRequest - Uri객체를 매개변수로 입력받음. 사이트 이동. Url -> Uri 자동 변환
    ..loadRequest(Uri.parse('https://blog.codefactory.ai'))
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Code Factory'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            webViewController.goBack();
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              webViewController
                  .loadRequest(Uri.parse('https://blog.codefactory.ai'));
            },
            icon: Icon(Icons.home, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              webViewController.goForward();
            },
            icon: Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
