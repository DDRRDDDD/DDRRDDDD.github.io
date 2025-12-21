import 'dart:async';
import 'dart:ui';

mixin LeadingDebounce {
  Timer? debounceTimer;
  bool _isWaiting = false;

  void debounce(VoidCallback callback, Duration duration) {
    if (_isWaiting) {
      return;
    }

    _isWaiting = true;
    callback();

    debounceTimer?.cancel();
    debounceTimer = Timer(duration, () {
      _isWaiting = false;
      debounceTimer = null;
    });
  }
}
