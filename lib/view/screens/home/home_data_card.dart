import 'package:feedbacksystem/models/feedback_home_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/gradient_Colors.dart';

class HomeDataCard extends ConsumerWidget {
  const HomeDataCard({
    super.key,
    required this.data,
    required this.onTap,
    required this.colors,
  });
  final FeedbackHomeDataModel data;
  final GradientColors colors;
  final void Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Container(
        //elevation: 1,

        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),

        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              alignment: Alignment.center,
              child: GradientText(
                text: data.teacher.name.substring(0, 2).toUpperCase(),
                style: GoogleFonts.roboto(
                    fontSize: 22, fontWeight: FontWeight.bold),
                gradient: LinearGradient(
                  colors: [
                    colors.firstColor,
                    colors.secondColor,
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    data.subjectModel.subjectCode,
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: const Color.fromARGB(255, 3, 18, 25),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    data.subjectModel.subjectName,
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 36, 71, 87),
                    ),
                    overflow: TextOverflow.visible,
                    softWrap: true,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    data.teacher.name,
                    style: GoogleFonts.roboto(
                      fontSize: 13,
                      color: const Color.fromARGB(255, 3, 18, 25),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText({
    Key? key,
    required this.text,
    this.style,
    required this.gradient,
  }) : super(key: key);
  final String text;
  final TextStyle? style;
  final Gradient gradient;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
