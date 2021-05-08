import 'package:estate_app/src/utils/toast.dart';
import 'package:flutter/material.dart';

class DoubleBackToCloseWidget extends StatefulWidget {
  final Widget child; // Make Sure this child has a Scaffold widget as parent.

  const DoubleBackToCloseWidget({
    @required this.child,
  });

  @override
  _DoubleBackToCloseWidgetState createState() =>
      _DoubleBackToCloseWidgetState();
}

class _DoubleBackToCloseWidgetState extends State<DoubleBackToCloseWidget> {
  int _lastTimeBackButtonWasTapped = 1;
  static const exitTimeInMillis = 2000;

  bool get _isAndroid => Theme.of(context).platform == TargetPlatform.android;

  @override
  Widget build(BuildContext context) {
    if (_isAndroid) {
      return WillPopScope(
        onWillPop: _handleWillPop,
        child: widget.child,
      );
    } else {
      return widget.child;
    }
  }

  Future<bool> _handleWillPop() async {
    final _currentTime = DateTime.now().millisecondsSinceEpoch;
    if (_lastTimeBackButtonWasTapped != null && (_currentTime - _lastTimeBackButtonWasTapped) < exitTimeInMillis) {
      Scaffold.of(context).removeCurrentSnackBar();
      showToast.displayToast("OK", Colors.red);
      print('DONE');
      return true;
    } else {
      _lastTimeBackButtonWasTapped = DateTime.now().millisecondsSinceEpoch;
      showToast.displayToast("AAA", Colors.red);
      return false;
    }
  }

  SnackBar _getExitSnackBar(
      BuildContext context,
      ) {
    return SnackBar(
      content: Text(
        'Press BACK again to exit!',
      ),
      backgroundColor: Colors.red,
      duration: const Duration(
        seconds: 2,
      ),
      behavior: SnackBarBehavior.floating,
    );
  }
}
