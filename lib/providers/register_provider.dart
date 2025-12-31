import 'package:d_method/d_method.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final registerStatusProvider = StateProvider.autoDispose((ref) => '');

setRegisterStatus(WidgetRef ref, String newStatus) {
  // Print status change for debugging
  DMethod.printTitle('setRegisterStatus', newStatus);

  ref.read(registerStatusProvider.notifier).state = newStatus;
}
