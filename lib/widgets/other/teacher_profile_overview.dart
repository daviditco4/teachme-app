import 'package:flutter/material.dart';
import 'package:teachme_app/widgets/other/tm_navigator.dart';

import '../info/teacher_profile_middle_info.dart';
import '../info/teacher_profile_top_info.dart';

class TeacherProfileOverview extends StatelessWidget {
  const TeacherProfileOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const verticalSpace = SizedBox(height: 16.0);

    return SingleChildScrollView(
      child: Column(
        children: [
          const TeacherProfileTopInfo(),
          verticalSpace,
          const Divider(),
          const TeacherProfileMiddleInfo(),
          verticalSpace,
          ElevatedButton(
            onPressed: () => TMNavigator.navigateToRoute(context, '/chat'),
            child: const Text('Ir a la sala'),
          ),
        ],
      ),
    );
  }
}
