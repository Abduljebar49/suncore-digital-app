class KycStatus {
  final String status;
  final String email;

  KycStatus({required this.status, required this.email});

  factory KycStatus.fromJson(Map<String, dynamic> json) {
    return KycStatus(status: json['status'], email: json['email']);
  }
}
