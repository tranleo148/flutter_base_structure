import 'package:flutter/material.dart';

class ErrorWithRetry extends StatelessWidget {
  final VoidCallback? onPressed;

  const ErrorWithRetry({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Cannot get data.\nPlease check the internet connection and try again!",
              style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          TextButton.icon(
              label: const Text(
                'Retry',
                style: TextStyle(fontSize: 18),
              ),
              icon: const Icon(Icons.refresh),
              onPressed: onPressed)
        ],
      ),
    );
  }
}
