class Job {
  int JobID;
  String jobTitle;
  String yearsOfExperience;
  String major;
  String descreption;
  String? city;
  Job(
      {required this.JobID,
      required this.jobTitle,
      required this.yearsOfExperience,
      required this.major,
      required this.descreption,
      this.city});
}
