import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:irusriproject/screens/detailscreen.dart';
import '../models/country.dart';
import '../services/rest_client.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late RestClient client;
  List<Country> countries = [];
  bool isLoading = true;
  String _sortCriteria = 'name';

  @override
  void initState() {
    super.initState();
    client = RestClient(Dio());
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    try {
      final response = await client.getEuropeanCountries();
      setState(() {
        countries = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load countries')),
      );
    }
  }

  void sortCountries() {
    setState(() {
      if (_sortCriteria == 'name') {
        countries.sort((a, b) => a.name.common.compareTo(b.name.common));
      } else if (_sortCriteria == 'population') {
        countries.sort((a, b) => a.population.compareTo(b.population));
      } else if (_sortCriteria == 'capital') {
        countries.sort((a, b) => a.capital.first.compareTo(b.capital.first));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('European Countries'),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _sortCriteria,
                onChanged: (String? newValue) {
                  setState(() {
                    _sortCriteria = newValue!;
                    sortCountries();
                  });
                },
                items: <String>['name', 'population', 'capital']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Icon(
                          value == 'name'
                              ? Icons.sort_by_alpha
                              : value == 'population'
                                  ? Icons.trending_up
                                  : Icons.location_city,
                          color: Colors.deepPurpleAccent,
                        ),
                        SizedBox(width: 10),
                        Text(value, style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  );
                }).toList(),
                dropdownColor: Colors.deepPurple,
                iconEnabledColor: Colors.white,
                style: TextStyle(color: Colors.white),
                hint: Text(
                  'Sort By',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
              ),
            )
          : ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  elevation: 6.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        country.flags.png,
                        width: 60,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      country.name.common,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      'Capital: ${country.capital.first}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.deepPurpleAccent,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CountryDetailScreen(country: country),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
