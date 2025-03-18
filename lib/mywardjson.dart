class mywardjson {
  final int PatientId, PhoneNumber, RelativePhoneNumber, WardId;
  final String FirstName,
      MiddleName,
      LastName,
      RelativeName,
      Relationship,
      AdmissionDatetime,
      WardName,
      ProfileCreationTime;

  mywardjson(
    this.WardId,
    this.WardName,
    this.PatientId,
    this.FirstName,
    this.MiddleName,
    this.LastName,
    this.PhoneNumber,
    this.RelativeName,
    this.RelativePhoneNumber,
    this.Relationship,
    this.ProfileCreationTime,
    this.AdmissionDatetime,
  );
}
