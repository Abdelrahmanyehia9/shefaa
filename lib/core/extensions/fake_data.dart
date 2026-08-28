extension FakeListExtension<T> on T {
  List<T> fakeList([int count = 5]) {
    return List.generate(count, (_) => this);
  }
}
