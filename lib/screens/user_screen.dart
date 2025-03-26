import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/profile_pic.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int runs = 20;
  int kilometers = 143;
  int followers = 69;
  late Map<String, int> profileStats = {"Runs": runs, "Kilometers": kilometers, "Followers": followers};

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.surfaceBright],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text("Profile", style: Theme.of(context).textTheme.bodyMedium),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 105),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: MyBoxDecorationDimed(),
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        Text(
                          "Aleksy Malawski",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                        ),
                        Divider(color: Colors.white, thickness: 2, indent: 20, endIndent: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ...List.generate(
                              3,
                              (index) => SizedBox(
                                width: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(profileStats[profileStats.keys.elementAt(index)].toString(),
                                        style: Theme.of(context).textTheme.bodyMedium),
                                    Text(profileStats.keys.elementAt(index),
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -85,
                    child: ProfilePic(),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    width: 195,
                    height: 300,
                    decoration: MyBoxDecorationDimed(),
                    child: Icon(Icons.settings, size: 80),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 95,
                          decoration: MyBoxDecorationDimed(),
                          child: Center(child: Text("data")),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 195,
                          decoration: MyBoxDecorationDimed(),
                          child: Center(child: Text("Weather API?")),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyBoxDecorationDimed extends BoxDecoration {
  MyBoxDecorationDimed()
      : super(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white.withValues(alpha: 0.23),
        );
}
