// ignore_for_file: non_constant_identifier_names

class JobData {
  int id;
  String jobTitle;
  String company;
  String shiftType;
  String description;
  String salary;
  String increaseText;
  String reviews;
  String jobPoster;

  JobData(
      {required this.jobTitle,
      required this.id,
      required this.company,
      required this.shiftType,
      required this.description,
      required this.salary,
      required this.reviews,
      required this.jobPoster,
      required this.increaseText});
}
