
class Task {
  final String id;
  final String name;
  final String person;
  final DateTime dateTime;
  bool isDone;


  Task({this.person, this.name, this.dateTime, this.isDone = false, this.id });

  void toggleDone() {
    isDone = !isDone;
  }
}
