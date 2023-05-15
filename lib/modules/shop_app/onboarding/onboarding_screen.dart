import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../shop_login/login_screen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.body, required this.title});
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boardingList = [
    BoardingModel(
        image: 'assets/images/onboarding.jpg',
        body: 'Screen Body 1',
        title: 'Screen Title 1'),
    BoardingModel(
        image: 'assets/images/onboarding.jpg',
        body: 'Screen Body 2',
        title: 'Screen Title 2'),
    BoardingModel(
        image: 'assets/images/onboarding.jpg',
        body: 'Screen Body 3',
        title: 'Screen Title 3'),
  ];

  PageController boardController = PageController();

  bool isLast = false;
  void submit ()
  {
   CacheHelper.saveData(key: 'onBoarding', value: true)!.then((value)
   {
     if (value)
     {
       navigateToAndKill(context,  const ShopLogin());
     }
   });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: const Text(
                'SKIP',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.blue),

              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index)
                {
                  if (index == boardingList.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boardingList[index]),
                physics: const BouncingScrollPhysics(),
                itemCount: boardingList.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SmoothPageIndicator(
                controller: boardController,
                count: boardingList.length,
                effect: const ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: Colors.blue,
                  spacing: 5.0,
                  dotWidth: 20.0,
                  dotHeight: 15.0,
                ),
              ),
              const Spacer(),
              FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    }
                    boardController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                  child: const Icon(Icons.arrow_forward_ios_outlined)),
            ]),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 24.0,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            model.body,
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      );
}
