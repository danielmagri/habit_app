import 'package:altitude/common/enums/back_data_item_type.dart';

class BackDataItem<T> {
  BackDataItem.added(this.data) : state = BackDataItemType.ADD;
  BackDataItem.update(this.data) : state = BackDataItemType.UPDATE;
  BackDataItem.removed(this.data) : state = BackDataItemType.REMOVE;

  final BackDataItemType state;
  final T data;
}
