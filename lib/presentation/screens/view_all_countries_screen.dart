import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../interface/firebase_interface.dart';
import '../../main.dart';
import '../../models/county_model.dart';
import '../../widgets/countryCard.dart';
import 'view_all_channel_screen.dart';

class ViewAllCountriesScreen extends StatefulWidget {
  const ViewAllCountriesScreen({
    super.key,
  });

  @override
  State<ViewAllCountriesScreen> createState() => _ViewAllCountriesScreenState();
}

class _ViewAllCountriesScreenState extends State<ViewAllCountriesScreen> {
  final searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    //  print('calling did change dependencies');
    callApis();
    super.didChangeDependencies();
  }

  bool isLoading = true;

  callApis() async {
    isLoading = true;

    commonController.countries.clear();

    await FirebaseInterface().getAllCountries();
    performSearch('', commonController.countries);

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black.withOpacity(0.7),
        title: const Text('All Countries'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 21),
            searchField(),
            const SizedBox(height: 11),
            isLoading
                ? Center(
                    child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.3,
                      ),
                      const CircularProgressIndicator(
                        color: Colors.deepOrange,
                      ),
                    ],
                  ))
                : Container(
                    width: Get.width,
                    height: Get.height,
                    margin: const EdgeInsets.symmetric(
                        vertical: 17, horizontal: 11),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisExtent: 120,
                        mainAxisSpacing: 11,
                      ),
                      itemCount: _filteredData.isEmpty
                          ? commonController.countries.length
                          : _filteredData.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () async {
                              if (_filteredData.isEmpty) {
                                Get.to(
                                  ViewAllChannelsScreen(
                                    title:
                                        commonController.countries[index].name,
                                    currentCountry: CountryModel(
                                        name: commonController
                                            .countries[index].name,
                                        file: commonController
                                            .countries[index].file,
                                        flag: ''),
                                  ),
                                );
                              } else {
                                Get.to(
                                  ViewAllChannelsScreen(
                                    title: _filteredData[index].name,
                                    currentCountry: CountryModel(
                                        name: _filteredData[index].name,
                                        file: _filteredData[index].file,
                                        flag: ''),
                                  ),
                                );
                              }
                            },
                            child: Column(
                              children: [
                                if (_filteredData.isNotEmpty &&
                                    searchController.text.isNotEmpty) ...{
                                  countryCard(
                                    backgroundImage: _filteredData[index].flag,
                                    countryName: _filteredData[index].name,
                                  ),
                                } else if (_filteredData.isEmpty &&
                                    searchController.text.isNotEmpty) ...{
                                  SizedBox()
                                } else ...{
                                  countryCard(
                                      backgroundImage: commonController
                                          .countries[index].flag,
                                      countryName: commonController
                                          .countries[index].name),
                                }
                              ],
                            ));
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget searchField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: Colors.grey,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: TextFormField(
              controller: searchController,
              onChanged: (value) =>
                  performSearch(value, commonController.countries),
              cursorColor: Colors.deepOrangeAccent,
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void searchFunction() {}

  List<CountryModel> _filteredData = [];

  void performSearch(String query, Iterable<CountryModel> data) {
    query = query.toLowerCase();
    setState(() {
      _filteredData.clear();

      if (query.isEmpty || query == '') {
        _filteredData.addAll(data);
      } else {
        //  print('here in else');

        _filteredData.addAll(data.where((item) {
          //    print('item name:' + item.name);
          return item!.name.toLowerCase().contains(query);
        }));

        //     print(_filteredData);
        //    print(_filteredData.length);
      }
    });
  }
}
