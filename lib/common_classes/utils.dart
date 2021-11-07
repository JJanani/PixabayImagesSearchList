import 'dart:collection';

bool isNull(dynamic value) {
  return value == null;
}

bool isNotNull(dynamic value) {
  return value != null;
}

bool isNotNullOrEmpty(dynamic x) {
  assert(x == null ||
      x is String ||
      x is List ||
      x is Map ||
      x is HashMap ||
      x is Queue ||
      x is Set);

  if (x == null) {
    return false;
  }

  if (x is String) {
    return x.isNotEmpty;
  }

  if (x is List) {
    return x.isNotEmpty;
  }

  if (x is Map) {
    return x.isNotEmpty;
  }

  if (x is HashMap) {
    return x.isNotEmpty;
  }

  if (x is Queue) {
    return x.isNotEmpty;
  }

  if (x is Set) {
    return x.isNotEmpty;
  }

  return false;
}
