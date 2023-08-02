import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/const/const_list.dart';
import 'package:flutter_mobile_bx/view/x_advice/controller/advisor_controller.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_model.dart';
import 'package:flutter_mobile_bx/widgets/loder.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({super.key, required this.filters});

  final List filters;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  AdvisorController advisorController = AdvisorController();
  int? selectedTypeCall;
  int? selectedTargetParameter;
  int? selectedsegmentList;
  int? selectedCategory;
  int? selectedDurationList;
  int? selectedSuperStarList;
  bool? showTargetParam = true;
  List<GetAdvisorListModel>? advisorList;
  RangeValues _currentRangeValues = const RangeValues(-100, 100);
  List<Map<String, dynamic>> durationList = [
    {
      "type": "all",
      "name": "All",
      'isSelected': false,
    },
    {
      "type": "intraday",
      "name": "Intraday",
      'isSelected': false,
    },
    {
      "type": "short term",
      "name": "Short Term",
      'isSelected': false,
    },
    {
      "type": "mid term",
      "name": "Mid Term",
      'isSelected': false,
    },
    {
      "type": "long term",
      "name": "Long Term",
      'isSelected': false,
    },
  ];
  @override
  void initState() {
    super.initState();
    advisorController = Provider.of<AdvisorController>(context, listen: false);
    advisorController.getAdvisorListController().then((value) {
      setFilters();
    });
  }

  setFilters() {
    double min = -100;
    double max = 100;
    widget.filters.forEach((e) {
      List lis = e["values"];
      if (e['field'] == 'advisorid') {
        final advisor = lis.isNotEmpty
            ? advisorList!
                .indexWhere((element) => element.blinkxAdvisorId == lis[0])
            : -1;
        selectedSuperStarList = advisor >= 0 ? advisor : null;
      }
      if (e['field'] == 'callduration') {
        final dur = lis.isNotEmpty
            ? durationList.indexWhere((element) => element['type'] == lis[0])
            : -1;
        selectedDurationList = dur >= 0 ? dur : 0;
      }
      if (e['field'] == 'subsegment') {
        final seg = lis.isNotEmpty
            ? ConstList()
                .segmentList
                .indexWhere((element) => element['type'] == lis[0])
            : -1;
        selectedsegmentList = seg >= 0 ? seg : 0;
      }
      if (e['field'] == 'calltype') {
        final type = lis.isNotEmpty
            ? ConstList().typeOfCall.indexWhere(
                (element) => element['name'].toString().toLowerCase() == lis[0])
            : -1;
        selectedTypeCall = type >= 0 ? type : 0;
      }
      if (e['field'] == 'callcategory') {
        final type = lis.isNotEmpty
            ? ConstList().categoryList.indexWhere(
                (element) => element['type'].toString().toUpperCase() == lis[0])
            : -1;
        selectedCategory = type >= 0 ? type : 0;
      }
      if (e['field'] == 'status') {
        showTargetParam = lis[0] == 'closed' ? true : false;
      }

      if (e['field'] == 'callpl' && e['operator'] == 'le') {
        max = double.parse(lis[0]);
      }
      if (e['field'] == 'callpl' && e['operator'] == 'ge') {
        min = double.parse(lis[0]);
      }
    });
    _currentRangeValues = (showTargetParam == true)
        ? RangeValues(min, max)
        : const RangeValues(-100, 100);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstColor.black42Color,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.04),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: ConstColor.whiteColor,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Consumer<AdvisorController>(
              builder: (context, value, child) {
                if (value.getAdvisorListModel.data == null) {
                  return CommanCircularLoader();
                } else {
                  advisorList = value.getAdvisorListModel.data;
                  return Padding(
                    padding: EdgeInsets.only(left: size.width * 0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.03),
                        _buildTypeOfCallList(size),
                        // showTargetParam == true
                        //     ? SizedBox(height: size.height * 0.03)
                        //     : SizedBox.shrink(),
                        // showTargetParam == true
                        //     ? _buildTargetParameterList(size)
                        //     : SizedBox.shrink(),
                        SizedBox(height: size.height * 0.03),
                        _buildSegmentList(size),
                        SizedBox(height: size.height * 0.03),
                        _buildCategoryList(size),
                        SizedBox(height: size.height * 0.03),
                        _buildDurationList(size),
                        showTargetParam == true
                            ? SizedBox(height: size.height * 0.03)
                            : SizedBox.shrink(),
                        showTargetParam == true
                            ? _buildNetGainView(size)
                            : SizedBox.shrink(),
                        // SizedBox(height: size.height * 0.03),
                        // _buildNetGainView(size),
                        SizedBox(height: size.height * 0.03),
                        _buildSuperStarList(
                            size, value.getAdvisorListModel.data),
                        SizedBox(height: size.height * 0.03),
                        _buildApplyFilter(
                          context,
                          size,
                          value.getAdvisorListModel.data,
                        ),
                        SizedBox(height: size.height * 0.02),
                        _buildButton(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          size: size,
                          title: 'Cancel',
                        ),
                        SizedBox(height: size.height * 0.05),
                      ],
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButtonView(
    BuildContext context,
    Size size,
    String title,
    void Function()? onTap,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffE13662),
                Color(0xffEB4954),
                Color(0xffD346F0),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.015),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: ConstColor.whiteColor,
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Build Button View
  Widget _buildButton(
      {required Size size,
      required String title,
      required void Function() onTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ConstColor.whiteColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(size.height * 0.05),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: size.width * 0.04,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: ConstColor.whiteColor,
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuperStarList(
    Size size,
    List<GetAdvisorListModel>? getAdvisorListData,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleName(size, 'Blinkx Super Stars'),
        SizedBox(height: size.height * 0.02),
        SizedBox(
          height: size.height * 0.26,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: size.width * 0.04),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSuperStarList = null;
                      });
                    },
                    child: Container(
                        width: size.width * 0.3,
                        decoration: BoxDecoration(
                          color: selectedSuperStarList == null
                              ? ConstColor.litePinkECColor.withOpacity(0.5)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.03,
                          vertical: size.height * 0.01,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: size.height * 0.02),
                            const Text(
                              "All Super Stars",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ConstColor.whiteColor,
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                          ],
                        )),
                  ),
                ),
                ListView.builder(
                  itemCount: getAdvisorListData!.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var advisorData = getAdvisorListData[index];
                    return Padding(
                      padding: EdgeInsets.only(left: size.width * 0.02),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (index == selectedSuperStarList) {
                              selectedSuperStarList = null;
                            } else {
                              selectedSuperStarList = index;
                            }
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: selectedSuperStarList == index
                                  ? ConstColor.litePinkECColor.withOpacity(0.5)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03,
                              vertical: size.height * 0.01,
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: size.height * 0.02),
                                CachedNetworkImage(
                                  imageUrl: advisorData.picLoc,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: size.height * 0.1,
                                    height: size.height * 0.1,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    width: size.height * 0.1,
                                    height: size.height * 0.1,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ConstColor.whiteColor),
                                    child: const Icon(
                                      Icons.person,
                                      color: ConstColor.black29Color,
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.02),
                                Text(
                                  advisorData.blinkxAdvisorName,
                                  style: TextStyle(
                                    color: ConstColor.whiteColor,
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.01),
                                SizedBox(
                                  width: size.width * 0.35,
                                  child: Text(
                                    advisorData.advisorDesignation,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ConstColor.whiteColor
                                          .withOpacity(0.7),
                                      fontSize: size.height * 0.013,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 2),
                                SizedBox(
                                  width: size.width * 0.35,
                                  child: Text(
                                    advisorData.advisorTeam!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: ConstColor.whiteColor
                                          .withOpacity(0.7),
                                      fontSize: size.height * 0.013,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildNetGainView(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleName(size, 'Net Gain'),
        SizedBox(height: size.height * 0.02),
        RangeSlider(
          values: _currentRangeValues,
          min: -100,
          max: 100,
          divisions: 200,
          activeColor: ConstColor.whiteColor,
          inactiveColor: ConstColor.whiteColor.withOpacity(0.5),
          labels: RangeLabels(
            "${_currentRangeValues.start.round()}%",
            "${_currentRangeValues.end.round()}%",
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
          },
        ),
      ],
    );
  }

  Widget _buildTypeOfCallList(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleName(size, "Type Of Call"),
        SizedBox(height: size.height * 0.018),
        _buildTypeCallListView(size: size)
      ],
    );
  }

  Widget _buildTypeCallListView({
    required Size size,
  }) {
    return SizedBox(
      height: size.height * 0.04,
      child: ListView.builder(
        itemCount: ConstList().typeOfCall.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var listData = ConstList().typeOfCall[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTypeCall = index;
                });
              },
              child: _buildListViewData(
                selectedTypeCall,
                index,
                size,
                listData['name'],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTargetParameterList(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleName(size, "Target Parameter"),
        SizedBox(height: size.height * 0.018),
        _buildTargetParameterListView(size: size)
      ],
    );
  }

  Widget _buildTargetParameterListView({
    required Size size,
  }) {
    return SizedBox(
      height: size.height * 0.04,
      child: ListView.builder(
        itemCount: ConstList().targetParameterList.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var listData = ConstList().targetParameterList[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: GestureDetector(
              onTap: () {
                // setState(() {
                //   selectedTargetParameter = index;
                // });
              },
              child: _buildListViewData(
                  selectedTargetParameter, index, size, listData['name']),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryList(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleName(size, "Category"),
        SizedBox(height: size.height * 0.018),
        _buildCategoryListView(size: size)
      ],
    );
  }

  Widget _buildCategoryListView({
    required Size size,
  }) {
    return SizedBox(
      height: size.height * 0.04,
      child: ListView.builder(
        itemCount: ConstList().categoryList.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var listData = ConstList().categoryList[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = index;
                });
              },
              child: _buildListViewData(
                  selectedCategory, index, size, listData['name']),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSegmentList(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleName(size, "Segment"),
        SizedBox(height: size.height * 0.018),
        _buildSegmentListView(size: size)
      ],
    );
  }

  Widget _buildSegmentListView({
    required Size size,
  }) {
    return SizedBox(
      height: size.height * 0.04,
      child: ListView.builder(
        itemCount: ConstList().segmentList.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var listData = ConstList().segmentList[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedsegmentList = index;
                });
              },
              child: _buildListViewData(
                  selectedsegmentList, index, size, listData['name']),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDurationList(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleName(size, "Duration"),
        SizedBox(height: size.height * 0.018),
        _buildDurationListView(size: size)
      ],
    );
  }

  Widget _buildDurationListView({
    required Size size,
  }) {
    return SizedBox(
      height: size.height * 0.04,
      child: ListView.builder(
        itemCount: durationList.length,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var listData = durationList[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedDurationList = index;
                });
              },
              child: _buildListViewData(
                  selectedDurationList, index, size, listData['name']),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListViewData(
    int? selectedIndex,
    int index,
    Size size,
    String title,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: selectedIndex == index
              ? ConstColor.whiteColor
              : ConstColor.whiteColor.withOpacity(0.2),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: ConstColor.whiteColor,
            fontSize: size.height * 0.018,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Text _buildTitleName(Size size, String title) {
    return Text(
      title,
      style: TextStyle(
        color: ConstColor.whiteColor,
        fontSize: size.height * 0.018,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildApplyFilter(
      BuildContext context, Size size, List<GetAdvisorListModel>? getAdvisor) {
    var dataList = widget.filters;
    return _buildButtonView(
      context,
      size,
      'Apply Filters',
      () {
        dataList.forEach((e) {
          if (e['field'] == 'advisorid') {
            e['values'] = selectedSuperStarList != null
                ? ["${getAdvisor?[selectedSuperStarList!].blinkxAdvisorId}"]
                : [];
          }
          if (e['field'] == 'callduration') {
            e['values'] =
                (selectedDurationList != null && selectedDurationList != 0)
                    ? [durationList[selectedDurationList!]['type']]
                    : [];
          }
          if (e['field'] == 'subsegment') {
            e['values'] =
                (selectedsegmentList != null && selectedsegmentList != 0)
                    ? [ConstList().segmentList[selectedsegmentList!]['type']]
                    : [];
          }
          if (e['field'] == 'calltype') {
            e['values'] = (selectedTypeCall != null && selectedTypeCall != 0)
                ? [
                    ConstList()
                        .typeOfCall[selectedTypeCall!]['name']
                        .toString()
                        .toLowerCase()
                  ]
                : [];
          }
          if (e['field'] == 'callcategory') {
            e['values'] = (selectedCategory != null && selectedCategory != 0)
                ? [
                    ConstList()
                        .categoryList[selectedCategory!]['type']
                        .toString()
                  ]
                : [];
          }
          if (e['field'] == 'callpl' && e['operator'] == 'le') {
            e['values'] = [_currentRangeValues.end.toString()];
          }
          if (e['field'] == 'callpl' && e['operator'] == 'ge') {
            e['values'] = [_currentRangeValues.start.toString()];
          }
          // if (e['field'] == 'status') {
          //   showTargetParam = e["values"][0] == 'closed' ? true : false;
          // }
        });
        // if (selectedTypeCall != null) {
        //   if (ConstList().typeOfCall[selectedTypeCall!]['name'] != 'All') {
        //     dataList.add({
        //       "operator": "eq",
        //       "values": [
        //         (ConstList()
        //             .typeOfCall[selectedTypeCall!]['name']
        //             .toString()
        //             .toLowerCase())
        //       ],
        //       "field": "calltype"
        //     });
        //   }
        // }
        // if (selectedDurationList != null && selectedDurationList != 0) {
        //   dataList.add({
        //     "operator": "eq",
        //     "values": [
        //       durationList[selectedDurationList!]['name']
        //           .toString()
        //           .toLowerCase()
        //     ],
        //     "field": "callduration"
        //   });
        // }
        // if (selectedsegmentList != null) {
        //   if (ConstList().segmentList[selectedsegmentList!]['name'] != 'All') {
        //     dataList.add({
        //       "operator": "eq",
        //       "values": [
        //         (ConstList()
        //             .segmentList[selectedsegmentList!]['type']
        //             .toString()
        //             .toUpperCase())
        //       ],
        //       "field": "subsegment"
        //     });
        //   }
        // }
        // if (selectedSuperStarList != null) {
        //   dataList.add({
        //     "operator": "eq",
        //     "values": [
        //       "${getAdvisor?[selectedSuperStarList!].blinkxAdvisorId}"
        //     ],
        //     "field": "advisorid"
        //   });
        // }

        Navigator.of(context).pop(dataList);
      },
    );
  }
}
