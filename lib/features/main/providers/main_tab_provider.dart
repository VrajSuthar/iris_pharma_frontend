import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_tab_provider.g.dart';

@riverpod
class MainTabController extends _$MainTabController {
  @override
  int build() => 0;

  void setTab(int index) => state = index;
}
