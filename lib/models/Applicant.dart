import 'package:flutter/material.dart';

class Applicant {
  String Name;
  String email;
  String? phone;
  String image;

  Applicant(
      {required this.Name,
      required this.email,
      required this.phone,
      required this.image});
}

List<Applicant> applicantList = [
  Applicant(
      Name: "Mohatdy Alehlal",
      email: "Mohtady.Alhelal@gmail.com",
      phone: "0566304423",
      image: ""),
  Applicant(
      Name: "Aqeel Almosa",
      email: "Aqeel.Almosa@gmail.com",
      phone: "0500000000",
      image: "")
];
