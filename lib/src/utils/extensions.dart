import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';

extension BuildContextX on BuildContext {
  SnackBar get snackBarFeatureNotAvailableYet => SnackBar(
        content: Text(
          l10n.featureNotAvailableYet,
          style: Theme.of(this).textTheme.bodyMedium,
        ),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: l10n.dismiss,
          textColor: Theme.of(this).primaryColor,
          onPressed: () {
            ScaffoldMessenger.of(this).hideCurrentSnackBar();
          },
        ),
      );

  Size get screenSize => MediaQuery.of(this).size;
}
