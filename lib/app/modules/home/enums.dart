enum PromiseType { BK }

extension PromiseTypeExtension on PromiseType {
  String get name {
    switch (this) {
      case PromiseType.BK:
        return 'Burger King';
      default:
        return null;
    }
  }

  int get value {
    switch (this) {
      case PromiseType.BK:
        return 0;
      default:
        return null;
    }
  }
}
