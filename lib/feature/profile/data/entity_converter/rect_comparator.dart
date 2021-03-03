import 'dart:ui';

bool isInside(Rect rect, Rect isInside) {
  if (rect == null) {
    return false;
  }

  if (isInside == null) {
    return false;
  }

  if (rect.center.dy <= isInside.bottom &&
      rect.center.dy >= isInside.top &&
      rect.center.dy >= isInside.right&&
      rect.center.dx <= 390) {
    return true;
  }
  return false;
}

bool isInside3rect({Rect isThisRect, Rect isInside, Rect andAbove}) {
  if (isThisRect == null) {
    return false;
  }

  if (isInside == null) {
    return false;
  }
  if (andAbove == null) {
    return false;
  }

  if (isThisRect.center.dy <= andAbove.top &&
      isThisRect.center.dy >= isInside.top &&
      isThisRect.center.dx >= isInside.left) {
    return true;
  }
  return false;
}