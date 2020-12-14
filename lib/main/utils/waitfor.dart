//import 'dart:core';
import 'dart:async';
import 'dart:math';

@pragma("vm:entry-point")
void Function(int) _waitForEventClosure;

class _WaitForUtils {
  static void waitForEvent({Duration timeout}) {
    final closure = _waitForEventClosure;
    if (closure == null) {
      throw new UnsupportedError("waitFor is not supported by this embedder");
    }
    closure(timeout == null ? 0 : max(1, timeout.inMilliseconds));
  }
}

T waitFor<T>(Future<T> future, {Duration timeout}) {
  T result;
  bool futureCompleted = false;
  Object error;
  StackTrace stacktrace;
  future.then((r) {
    futureCompleted = true;
    result = r;
  }, onError: (e, st) {
    error = e;
    stacktrace = st;
  });

  Stopwatch s;
  if (timeout != null) {
    s = new Stopwatch()..start();
  }
  Timer.run(() {}); // Enusre there is at least one message.
  while (!futureCompleted && (error == null)) {
    Duration remaining;
    if (timeout != null) {
      if (s.elapsed >= timeout) {
        throw new TimeoutException("waitFor() timed out", timeout);
      }
      remaining = timeout - s.elapsed;
    }
    _WaitForUtils.waitForEvent(timeout: remaining);
  }
  if (timeout != null) {
    s.stop();
  }
  Timer.run(() {}); // Ensure that previous calls to waitFor are woken up.

  if (error != null) {
    throw new AsyncError(error, stacktrace);
  }

  return result;
}
