import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../repositories/ceosi_freedomwall/freedom_posts_repository.dart';

final postProvider = Provider<FreedomPostsRepository>(
  (ref) {
    return FreedomPostsRepository();
  },
);

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

class IsAdminNotifier extends StateNotifier<bool> {
  IsAdminNotifier() : super(false);

  isAdmin(bool value) {
    state = value;
  }
}

final IsAdminProvider = StateNotifierProvider<IsAdminNotifier, bool>((ref) {
  return IsAdminNotifier();
});
