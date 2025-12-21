import 'package:flutter_layout_grid/flutter_layout_grid.dart';

extension TrackSizeExtension on TrackSize {
  List<TrackSize> operator *(int count) {
    return List<TrackSize>.filled(count, this);
  }
}