class Job {
  int jobID = 0;
  String jobTitle;
  String yearsOfExperience;
  String major;
  String descreption;
  String? city;
  Job(
      {required this.jobID,
      required this.jobTitle,
      required this.yearsOfExperience,
      required this.major,
      required this.descreption,
      this.city});
}
