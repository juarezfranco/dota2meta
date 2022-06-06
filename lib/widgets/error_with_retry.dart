import 'package:dota2meta/support/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';

class ErrorWithRetry extends StatelessWidget {
  final String message;
  final VoidCallback retryPressed;

  const ErrorWithRetry({
    required this.message,
    required this.retryPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LineIcon.exclamationTriangle(
            size: 28,
            color: Colors.grey,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.grey,
              )
            ),
          ),
          const SizedBox(width: 4),
          TextButton(
            onPressed: retryPressed,
            child: Text(AppLocalizations.of(context).retry),
          ),
        ],
      ),
    );
  }
}
