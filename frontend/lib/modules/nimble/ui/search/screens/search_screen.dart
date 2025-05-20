import 'package:frontend/modules/nimble/helpers/data_generator.dart';
import 'package:frontend/modules/nimble/models/search_result_model.dart';
import 'package:frontend/modules/nimble/resources/colors.dart';
import 'package:frontend/modules/shared/components/image/image_component.dart';
import 'package:frontend/modules/shared/components/loading/loading_component.dart';
import 'package:frontend/modules/shared/helpers/utils.dart';
import 'package:frontend/modules/shared/resources/dimensions.dart';
import 'package:frontend/modules/shared/resources/themes.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<SearchResultModel> searchResults = [];
  bool isLoadingData = false;
  bool isSearchQueryFound = false;
  bool isSearchFieldSubmitted = false;
  var searchText = "";
  String _selectedValue = '1';

  String searchFieldButtonText = 'Cancel';

  String? price = '\$12.00';

  Future<void> init() async {
    changeStatusColor(primaryBrandColor);
  }

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var searchHistoryList = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16),
          child: Text("Search history", style: secondaryTextStyle()),
        ),
        ListView.builder(
          itemCount: searchQueryList.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 16),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          searchController.text = searchQueryList[index].value!;
                          FocusManager.instance.primaryFocus?.unfocus();
                          _performSearch(searchController.text);
                        },
                        child: Row(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                              padding: const EdgeInsets.all(4),
                              child: const Icon(Icons.star,
                                  color: Colors.white, size: 12),
                            ),
                            const SizedBox(
                              width: spacing16,
                            ),
                            Text(
                              searchQueryList[index].value!,
                              style: primaryTextStyle(),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right,
                        color: primaryAppIconColor,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: viewAppColor,
                  height: 1,
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                ),
              ],
            );
          },
        ),
      ],
    );
    var nothingFound = Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 250),
          Text(
            "No results found for \"${searchController.text}\"",
            style: boldTextStyle(size: 22),
          ),
          const SizedBox(height: 8),
          Text(
            "Try a diffetent keyword",
            style: secondaryTextStyle(),
          ),
          GestureDetector(
            onTap: () {
              setState(
                () {
                  searchController.clear();
                  searchResults.clear();
                  isSearchQueryFound = false;
                  isLoadingData = false;
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    var searchResultsList = ListView.builder(
      itemCount: searchResults.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // TODO: implement action
          },
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: spacing16,
              left: spacing16,
              right: spacing16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: spacing16, bottom: spacing16),
                  child: Text('23 October, 2021', style: boldTextStyle()),
                ),
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: spacing8),
                      child: Container(
                        decoration: boxDecoration(
                            radius: 8, backgroundColor: Colors.grey[200]),
                        child: Column(
                          children: [
                            const SizedBox(height: spacing16),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: spacing16, right: spacing16),
                              child: Row(
                                children: [
                                  ClipRect(
                                    child: ImageComponent(
                                      url: searchResults[index].imageOne!,
                                      placeHolder:
                                          searchResults[index].imageOne!,
                                      height: 75,
                                      width: 75,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: spacing8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        searchResults[index].medicineOne!,
                                        style: boldTextStyle(),
                                      ),
                                      // createRichText(
                                      //   overflow: TextOverflow.ellipsis,
                                      //   list: <TextSpan>[
                                      //     TextSpan(
                                      //         text: e.medicineOne,
                                      //         style: boldTextStyle()),
                                      //     const TextSpan(text: ''),
                                      //   ],
                                      // ),
                                      const SizedBox(height: spacing8),
                                      Text(('Tablets : 50 pills'),
                                          style: secondaryTextStyle()),
                                      const SizedBox(height: spacing12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('Quantity: ',
                                              style: boldTextStyle(
                                                  color: Colors.grey.shade500,
                                                  size: 14)),
                                          const SizedBox(width: spacing4),
                                          Text(
                                            '02 ',
                                            style: boldTextStyle(
                                                color: Colors.white
                                                // frontendStore.isDarkModeOn
                                                //     ? white
                                                //     : blackColor,
                                                ),
                                          ),
                                          const SizedBox(width: spacing8),
                                          Text('\$12.00',
                                              style: boldTextStyle(
                                                  size: 14,
                                                  color: Colors.blue)),
                                        ],
                                      ),
                                      const SizedBox(height: spacing8),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: spacing8),
                            const Divider(thickness: 0.5),
                            const SizedBox(height: spacing8),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: spacing16, right: spacing16),
                              child: Row(
                                children: [
                                  Text('Total: ', style: boldTextStyle()),
                                  Text('\$300.00',
                                      style: boldTextStyle(
                                          color: appPrimaryDarkColor)),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(' Detail',
                                            style: boldTextStyle(
                                                size: 14,
                                                color: appPrimaryDarkColor)),
                                        const SizedBox(width: spacing4),
                                        const Icon(Icons.arrow_forward,
                                            color: appPrimaryDarkColor,
                                            size: 16),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: spacing16),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: spacing16),
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: boxDecoration(
                          backgroundColor:
                              (searchResults[index].status! == 'Cheapest')
                                  ? Colors.orange
                                  : Colors.blue,
                          radius: 20,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: spacing10, right: spacing10),
                          child: Text(
                            (searchResults[index].status!),
                            style: secondaryTextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryBrandColor,
        automaticallyImplyLeading: false,
        title: const Text('Search'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                _selectedValue = value;
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    searchQueryList.clear();
                  });
                },
                value: '1',
                child: const Text('Clear History'),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: boxDecoration(
                        radius: 6,
                        backgroundColor: viewAppColor.withOpacity(0.8),
                      ),
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start,
                        controller: searchController,
                        onSubmitted: (value) {
                          _performSearch(value);
                          isSearchFieldSubmitted = true;
                        },
                        onChanged: (value) {
                          if (searchController.text.isNotEmpty) {
                            setState(() {
                              searchFieldButtonText = 'Clear';
                            });
                          } else {
                            setState(() {
                              searchFieldButtonText = 'Cancel';
                            });
                          }
                        },
                        autofocus: true,
                        style: const TextStyle(fontSize: 20),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search, color: Colors.black),
                          hintText: 'Enter Search',
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(
                        () {
                          searchController.clear();
                          searchResults.clear();
                          isSearchQueryFound = false;
                          isLoadingData = false;
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        searchFieldButtonText,
                        style: primaryTextStyle(
                            color: primaryBrandColor, size: 15),
                      ),
                    ),
                  )
                ],
              ),
            ),
            isLoadingData
                ? const LoadingComponent()
                : isSearchQueryFound
                    ? searchResultsList
                    : isSearchFieldSubmitted
                        ? nothingFound
                        : searchHistoryList,
          ],
        ),
      ),
    );
  }

  void _performSearch(String value) {
    setState(() {
      isLoadingData = true;
    });
    // TODO: Remove in production
    Future.delayed(const Duration(seconds: 2), () {
      return loadSearchResults(searchController.text);
    }).then((result) => {
          setState(() {
            searchResults.clear();
            searchController.clear();
            searchResults.addAll(result);
            isSearchQueryFound = searchResults.isNotEmpty;

            isLoadingData = false;
            searchText = value;
            searchQueryList.add(SearchModel(value: value));
            isSearchFieldSubmitted = false;
            searchFieldButtonText = 'Cancel';
          }),
        });
  }
}
