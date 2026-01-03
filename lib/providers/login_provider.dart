import 'package:d_method/d_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final loginStatusProvider = StateProvider.autoDispose((ref) => '');

setLoginStatus(WidgetRef ref, String newStatus) {
  // Print status change for debugging
  DMethod.printTitle('setLoginStatus', newStatus);

  ref.read(loginStatusProvider.notifier).state = newStatus;
}
