import 'package:flutter/material.dart';
import '../FailureReportPages/form_page3.dart';


class NewForm extends StatefulWidget {
  @override
  final Key? key;
  const NewForm({this.key}) : super(key: key);
  @override
  FormState createState() => FormState();
}

class FormState extends State<NewForm> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  List<Widget> formPages = [

    const FormPage(),

    // Add more form pages as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              children: formPages,
            ),
          ),
          Row(
            mainAxisAlignment:_currentPageIndex==0? MainAxisAlignment.end:MainAxisAlignment.spaceBetween,
            children: [
              if (_currentPageIndex > 0)
                ElevatedButton(
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text('Previous'),
                ),
              if (_currentPageIndex < formPages.length - 1)
                ElevatedButton(
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text('Next'),
                ),
              if (_currentPageIndex == formPages.length - 1)
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();                  },
                  child: const Text('Submit'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}