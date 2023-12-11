import 'package:dota2meta/support/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

const kAvatarSize = 200.0;

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.about),
      ),
      body: ListView(
        padding: const EdgeInsets.all(26),
        children: [
          Text(locale.projectDescription),
          const SizedBox(
            height: 26,
          ),
          const Center(
            child: Text(
              "Dev",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          const Divider(),
          const SizedBox(
            height: 12,
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kAvatarSize),
              child: Image.network(
                'https://avatars.githubusercontent.com/u/8771411?v=1',
                height: kAvatarSize,
                width: kAvatarSize,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const Center(
            child: Text(
              'Juarez Franco',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Center(
            child: InkWell(
              onTap: () {
                launchUrlString('https://github.com/juarezfranco/dota2meta');
              },
              child: Text(
                'github.com/juarezfranco/dota2meta',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
