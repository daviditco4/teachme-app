import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  TopBar({
    Key? key,
    required this.title,
    this.showLogo = true,
    this.showNotifications = true,
    this.showSettings = false,
  }) : super(key: key) {
    const logoWithPaddingDimension = 80.0;

    appBar = AppBar(
      // backgroundColor: Colors.transparent,
      elevation: 0.0,
      toolbarHeight: logoWithPaddingDimension,
      leadingWidth: logoWithPaddingDimension,
      centerTitle: true,
      leading: showLogo
          ? Padding(
              padding: const EdgeInsets.all(logoWithPaddingDimension * 0.1),
              child: Image.asset(
                'assets/images/teachme_logo.png',
                fit: BoxFit.contain,
              ),
            )
          : null,
      title: Text(title),
      actions: showNotifications || showSettings
          ? [
              if (showSettings)
                IconButton(
                  onPressed: () {
                    // TODO: Route to settings page
                  },
                  icon: const Icon(Icons.settings),
                ),
              if (showNotifications)
                IconButton(
                  onPressed: () {
                    // TODO: Route to notifications page
                  },
                  icon: const Icon(Icons.notifications_outlined),
                ),
            ]
          : null,
    );
  }

  final String title;
  final bool showLogo;
  final bool showNotifications;
  final bool showSettings;
  late final AppBar appBar;

  @override
  Size get preferredSize => appBar.preferredSize;
  @override
  Widget build(BuildContext context) => appBar;
}
