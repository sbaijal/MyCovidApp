class myjson {
  final int PatientId, PhoneNumber, RelativePhoneNumber;
  final String FirstName,
      MiddleName,
      LastName,
      RelativeName,
      Relationship,
      AdmissionDatetime;

  myjson(
      this.FirstName,
      this.MiddleName,
      this.LastName,
      this.RelativeName,
      this.Relationship,
      this.AdmissionDatetime,
      this.PhoneNumber,
      this.RelativePhoneNumber,
      this.PatientId);
}
