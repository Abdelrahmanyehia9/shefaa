import 'dart:async';

class AppTimer {
  final int duration;
  final void Function()? onTick;
  final void Function()? onFinish;
  final Duration tickDuration;

  late int _remainingSeconds;
  Timer? _timer;
  bool _isPaused = false;
  bool _isRunning = false;

  AppTimer({
    required this.duration,
    this.onTick,
    this.onFinish,
    this.tickDuration = const Duration(seconds: 1),
  }) {
    _remainingSeconds = duration;
  }

  void start() {
    if (_isRunning) return;
    if (_remainingSeconds <= 0) {
      _remainingSeconds = duration;
    }
    _isRunning = true;
    _isPaused = false;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(tickDuration, (timer) {
      if (_isPaused) return;

      _remainingSeconds--;
      onTick?.call();

      if (_remainingSeconds <= 0) {
        timer.cancel();
        _isRunning = false;
        onFinish?.call();
      }
    });
  }

  void pause() {
    if (!_isRunning) return;
    _isPaused = true;
  }

  void resume() {
    if (!_isRunning || !_isPaused) return;
    _isPaused = false;
  }

  void cancel() {
    _timer?.cancel();
    _isRunning = false;
    _isPaused = false;
    _remainingSeconds = duration;
  }

  int get remainingSeconds => _remainingSeconds;
  bool get isPaused => _isPaused;
  bool get isRunning => _isRunning;
}
