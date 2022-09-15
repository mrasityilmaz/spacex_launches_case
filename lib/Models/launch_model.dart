class LaunchModel {
  Links? links;
  String? rocket;
  bool? success;
  List<Failures>? failures;
  String? details;
  int? flightNumber;
  String? name;
  String? dateUtc;
  bool? upcoming;
  String? id;

  LaunchModel(
      {this.links,
      this.rocket,
      this.success,
      this.failures,
      this.details,
      this.flightNumber,
      this.name,
      this.dateUtc,
      this.upcoming,
      this.id});

  LaunchModel.fromJson(Map<String, dynamic> json) {
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    rocket = json['rocket'];
    success = json['success'];
    if (json['failures'] != null) {
      failures = <Failures>[];
      json['failures'].forEach((v) {
        failures!.add(Failures.fromJson(v));
      });
    }
    details = json['details'];
    flightNumber = json['flight_number'];
    name = json['name'];
    dateUtc = json['date_utc'];
    upcoming = json['upcoming'];
    id = json['id'];
  }
}

class Links {
  Patch? patch;
  Reddit? reddit;

  Links({
    this.patch,
    this.reddit,
  });

  Links.fromJson(Map<String, dynamic> json) {
    patch = json['patch'] != null ? Patch.fromJson(json['patch']) : null;
    reddit = json['reddit'] != null ? Reddit.fromJson(json['reddit']) : null;
  }
}

class Patch {
  String? small;
  String? large;

  Patch({this.small, this.large});

  Patch.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    large = json['large'];
  }
}

class Reddit {
  String? campaign;

  String? recovery;

  Reddit({this.campaign, this.recovery});

  Reddit.fromJson(Map<String, dynamic> json) {
    campaign = json['campaign'];

    recovery = json['recovery'];
  }
}

class Failures {
  int? time;

  String? reason;

  Failures({this.time, this.reason});

  Failures.fromJson(Map<String, dynamic> json) {
    time = json['time'];

    reason = json['reason'];
  }
}
