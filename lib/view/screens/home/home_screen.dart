import 'dart:math';

import 'package:feedbacksystem/helper/extentions/widget_padding.dart';
import 'package:feedbacksystem/helper/shared_state/updator.dart';
import 'package:feedbacksystem/view/screens/home/home_data_card.dart';
import 'package:feedbacksystem/view/widgets/async_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../apis/auth_api.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/feedback_controller.dart';
import '../../../models/gradient_Colors.dart';
import '../auth/sign_in_screen.dart';
import '../feedback/feedback_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  static route() => MaterialPageRoute(builder: (context) => const HomeScreen());

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<GradientColors> colors = [
    GradientColors(
      firstColor: const Color(0xffc31432),
      secondColor: const Color(0xff240b36),
    ),
    GradientColors(
      firstColor: const Color(0xffad5389),
      secondColor: const Color(0xff3c1053),
    ),
    /*GradientColors(
      firstColor: const Color(0xff77A1D3),
      secondColor: const Color(0xffe684ae),
    ),*/
    GradientColors(
      firstColor: const Color(0xff200122),
      secondColor: const Color(0xff6f0000),
    ),
    GradientColors(
      firstColor: const Color(0xff5C258D),
      secondColor: const Color(0xff4389A2),
    ),
    GradientColors(
      firstColor: const Color(0xffFF8008),
      secondColor: const Color(0xffFFC837),
    ),
    GradientColors(
      firstColor: const Color(0xff799F0C),
      secondColor: const Color(0xffacbb78),
    ),
  ];
  Random random = Random();
  int getRandomColorIndex() {
    int randomNumber = random.nextInt(6);

    return randomNumber;
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserDetailsProvider);
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('Available Feedbacks'),
        actions: [
          Container(
            width: 80,
            height: 25,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                ref.read(authApiProvider).signout();
                ref.read(futureStateUpdator.notifier).update();
                Navigator.pushReplacement(
                  context,
                  SignInScreen.route(),
                );
              },
              child: Text("Signout"),
            ),
          ),
        ],
      ),
      body: AsyncValueWidget(
        value: user,
        data: (user) {
          return Center(
            child: user == null
                ? const Text('No user found')
                : AsyncValueWidget(
                    value: ref.watch(feedbackSubjectsProvider(user.id)),
                    data: (feedbackHomeModel) {
                      return feedbackHomeModel.isEmpty
                          ? const Center(child: Text("No pending feedbacks"))
                          : ListView.builder(
                              itemCount: feedbackHomeModel.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 5),
                                  child: HomeDataCard(
                                    data: feedbackHomeModel[index],
                                    colors: colors[getRandomColorIndex()],
                                    onTap: () {
                                      Navigator.of(context).push(
                                        FeedbackScreen.route(
                                            feedbackHomeModel[index]),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                    },
                  ),
          ).addPadding(3);
        },
      ),
    );
  }
}
