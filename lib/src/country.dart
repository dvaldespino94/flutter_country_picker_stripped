import 'package:country_picker/src/country_parser.dart';
import 'package:country_picker/src/utils.dart';

///The country Model that has all the country
///information needed from the [country_picker]
class Country {
  static Country worldWide = Country(
    phoneCode: '',
    countryCode: 'WW',
    e164Sc: -1,
    name: 'World Wide',
    displayName: 'World Wide (WW)',
  );

  ///The country phone code
  final String phoneCode;

  ///The country code, ISO (alpha-2)
  final String countryCode;
  final int e164Sc;

  ///The country name in English
  final String name;

  final String displayName;

  Country({
    required this.phoneCode,
    required this.countryCode,
    required this.e164Sc,
    required this.name,
    required this.displayName,
  });

  Country.from({required Map<String, dynamic> json})
      : phoneCode = json['e164_cc'] as String,
        countryCode = json['iso2_cc'] as String,
        e164Sc = json['e164_sc'] as int,
        name = json['name'] as String,
        displayName = json['display_name'] as String;

  static Country parse(String country) {
    if (country == worldWide.countryCode) {
      return worldWide;
    } else {
      return CountryParser.parse(country);
    }
  }

  static Country? tryParse(String country) {
    if (country == worldWide.countryCode) {
      return worldWide;
    } else {
      return CountryParser.tryParse(country);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['e164_cc'] = phoneCode;
    data['iso2_cc'] = countryCode;
    data['e164_sc'] = e164Sc;
    data['name'] = name;
    data['display_name'] = displayName;
    return data;
  }

  bool startsWith(
    String query,
  ) {
    String _query = query;
    if (query.startsWith("+")) {
      _query = query.replaceAll("+", "").trim();
    }
    return phoneCode.startsWith(_query.toLowerCase()) ||
        name.toLowerCase().startsWith(_query.toLowerCase()) ||
        countryCode.toLowerCase().startsWith(_query.toLowerCase());
  }

  bool get iswWorldWide => countryCode == Country.worldWide.countryCode;

  @override
  String toString() => 'Country(countryCode: $countryCode, name: $name)';

  @override
  bool operator ==(Object other) {
    if (other is Country) {
      return other.countryCode == countryCode;
    }

    return super == other;
  }

  @override
  int get hashCode => countryCode.hashCode;

  /// provides country flag as emoji.
  /// Can be displayed using
  ///
  ///```Text(country.flagEmoji)```
  String get flagEmoji => Utils.countryCodeToEmoji(countryCode);
}
