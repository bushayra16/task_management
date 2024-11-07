class Urls {
  static String baseUrl = 'http://35.73.30.144:2005/api/v1';
  static String registration = '$baseUrl/Registration';
  static String login = '$baseUrl/Login';
  static String createTask = '$baseUrl/createTask';
  static String getNewTaskList = '$baseUrl/listTaskByStatus/New';
  static  String completedTaskList = '$baseUrl/listTaskByStatus/Completed';
  static  String canceledTaskList = '$baseUrl/listTaskByStatus/Canceled';
  static  String progressTaskList = '$baseUrl/listTaskByStatus/Progress';
  static  String changeTaskStatus(String taskId, String status) => '$baseUrl/updateTaskStatus/$taskId/$status';
  static  String deleteTask(String taskId) => '$baseUrl/deleteTask/$taskId';
  static  String getTaskCount() => '$baseUrl/taskStatusCount';


}