import 'package:hive/hive.dart';
import 'package:taskati/core/model/task_model.dart';

// Task Adapter
class TaskAdapter extends TypeAdapter<TaskModel> {

  // 1
  @override
  // 0-223
   int get typeId => 0; // Type ID unique for TaskModel

// 2
  @override
  TaskModel read(BinaryReader reader) {
    return TaskModel(
      id: reader.readString(),
      title: reader.readString(),
      note: reader.readString(),
      date: reader.readString(),
      startTime: reader.readString(),
      endTime: reader.readString(),
      Color: reader.readInt(),
      isCompleted: reader.readBool(),
    );
  }

// 3
  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.note);
    writer.writeString(obj.date);
    writer.writeString(obj.startTime);
    writer.writeString(obj.endTime);
    writer.writeInt(obj.Color);
    writer.writeBool(obj.isCompleted);
  }
}