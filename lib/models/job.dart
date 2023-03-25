class Job {
  String jobID;
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
