import '../models/country.dart';

class CountryService {
  Future<List<Country>> fetchCountries() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      Country(
        name: 'Brasil',
        flagUrl: 'https://flagcdn.com/w320/br.png',
      ),
      Country(
        name: 'Estados Unidos',
        flagUrl: 'https://flagcdn.com/w320/us.png',
      ),
      Country(
        name: 'Alemanha',
        flagUrl: 'https://flagcdn.com/w320/de.png',
      ),
      Country(
        name: 'Japão',
        flagUrl: 'https://flagcdn.com/w320/jp.png',
      ),
      Country(
        name: 'Canadá',
        flagUrl: 'https://flagcdn.com/w320/ca.png',
      ),
      Country(
        name: 'França',
        flagUrl: 'https://flagcdn.com/w320/fr.png',
      ),
      Country(
        name: 'Itália',
        flagUrl: 'https://flagcdn.com/w320/it.png',
      ),
      Country(
        name: 'Reino Unido',
        flagUrl: 'https://flagcdn.com/w320/gb.png',
      ),
      Country(
        name: 'Espanha',
        flagUrl: 'https://flagcdn.com/w320/es.png',
      ),
      Country(
        name: 'Austrália',
        flagUrl: 'https://flagcdn.com/w320/au.png',
      ),
    ];
  }
}
