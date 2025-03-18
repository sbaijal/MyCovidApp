class myvitals {
  final int PatientId,
      NurseId,
      DoctorId,
      PulseRate,
      RespiratoryRate,
      BpSystolic,
      BpDiastolic,
      SpO2,
      O2,
      Temperature;
  final String StaffName, Remarks, StatusDatetime;

  myvitals(
      this.StaffName,
      this.PatientId,
      this.NurseId,
      this.DoctorId,
      this.StatusDatetime,
      this.PulseRate,
      this.RespiratoryRate,
      this.BpSystolic,
      this.BpDiastolic,
      this.SpO2,
      this.O2,
      this.Temperature,
      this.Remarks);
}
