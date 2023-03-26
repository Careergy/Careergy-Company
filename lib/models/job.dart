class Job {
  String? id;
  String jobTitle;
  String yearsOfExperience;
  String major;
  String descreption;
  String city;
  DateTime? dt;
  bool isActive;
  Job(
      {this.id,
      this.dt,
      required this.jobTitle,
      required this.yearsOfExperience,
      required this.major,
      required this.descreption,
      required this.city,
       this.isActive = true});
}
