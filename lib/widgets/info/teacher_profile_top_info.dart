import 'package:flutter/material.dart';

class TeacherProfileTopInfo extends StatelessWidget {
  const TeacherProfileTopInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final headlineStyle = textTheme.headlineSmall;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircleAvatar(
          radius: 75.0,
          backgroundImage: AssetImage('assets/images/profile_photo.png'),
        ),
        const SizedBox(height: 15.0),
        Text('Sala General', style: headlineStyle),
        const SizedBox(height: 5.0),
        Text('Utilice la conversación grupal', style: headlineStyle),
        const SizedBox(height: 30.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text('Precio por clase:', style: textTheme.titleLarge),
            const Spacer(),
            Text('A definir', style: headlineStyle),
          ],
        ),
      ],
    );
  }
}
