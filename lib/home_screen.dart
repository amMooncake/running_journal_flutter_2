import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:running_journal_flutter_2/screens/my_screens.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
export 'screens/my_screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedNavScreen = 0;
  int previouslySelected = 0;

  @override
  Widget build(BuildContext context) {
    List<Icon> navIcons = [
      Icon(selectedNavScreen == 0 ? CupertinoIcons.book_fill : CupertinoIcons.book, size: 40),
      Icon(selectedNavScreen == 1 ? CupertinoIcons.add_circled_solid : CupertinoIcons.add_circled, size: 40),
      Icon(selectedNavScreen == 2 ? CupertinoIcons.number_circle_fill : CupertinoIcons.number_circle, size: 40),
      Icon(selectedNavScreen == 3 ? CupertinoIcons.person_fill : CupertinoIcons.person, size: 40),
    ];

    const List<Widget> navScreens = [
      CalculateScreen(),
      JournalScreen(),
      AddTrainingScreen(),
      UserScreen(),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        alignment: Alignment.center,
        children: [
          ...List.generate(
            navScreens.length,
            (index) {
              return AnimatedPositioned(
                duration: Duration(milliseconds: (selectedNavScreen == index || previouslySelected == index) ? 500 : 0),
                curve: Curves.easeOut,
                right: selectedNavScreen == index
                    ? 0
                    : selectedNavScreen < index
                        ? -1 * MediaQuery.of(context).size.width
                        : 1 * MediaQuery.of(context).size.width,
                child: navScreens[index],
              );
            },
          ),
          Positioned(
            bottom: 24,
            child: Container(
              width: 330,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                // color: Colors.white,
                color: Theme.of(context).colorScheme.surfaceDim,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  navIcons.length,
                  (index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          previouslySelected = selectedNavScreen;
                          selectedNavScreen = index;
                          print(selectedNavScreen);
                        });
                      },
                      child: navIcons[index],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
