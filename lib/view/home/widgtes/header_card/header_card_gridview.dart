import 'package:flutter/material.dart';
import 'package:flutter_mobile_bx/const/color.dart';
import 'package:flutter_mobile_bx/view/x_advice/model/get_advisor_call_model.dart';

class HeaderCardGridView extends StatefulWidget {
  final AdvisoryResults? advisoryResults;

  const HeaderCardGridView({
    super.key,
    required this.advisoryResults,
  });

  @override
  State<HeaderCardGridView> createState() => _HeaderCardGridViewState();
}

class _HeaderCardGridViewState extends State<HeaderCardGridView> {
  List<Map<String, dynamic>> cardGridList = [];

  @override
  void initState() {
    super.initState();
    cardGridList = [
      {
        'name': 'Suitable for',
        'value': widget.advisoryResults!.callCategoryText,
      },
      {
        'name': 'Category',
        'value': widget.advisoryResults?.callcategory,
      },
      {
        'name': 'Duration',
        'value': widget.advisoryResults?.callduration,
      },
      {
        'name': 'Expiry date',
        'value': widget.advisoryResults!.expirydate,
      },
      (widget.advisoryResults!.status == 'closed' ||
              widget.advisoryResults!.callduration == 'intraday')
          ? {
              'name': '',
              'value': '',
            }
          : (widget.advisoryResults!.isCash == false
              ? {
                  'name': 'Contract Expiry',
                  'value': widget.advisoryResults!.contractexpiry!
                      .split(" ")[0]
                      .toString(),
                }
              : {
                  'name': 'Days left',
                  'value': "${widget.advisoryResults!.daysLeft} days",
                }),
      widget.advisoryResults!.subsegment == "NSECALL" ||
              widget.advisoryResults!.subsegment == "NSEPUT"
          ? {
              'name': 'Call/Put',
              'value': widget.advisoryResults!.subsegment == "NSECALL"
                  ? "Call"
                  : "Put",
            }
          : {
              'name': '',
              'value': '',
            },
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2 / 1,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cardGridList.length,
      itemBuilder: (context, index) {
        var categoryData = cardGridList[index];
        return Column(
          children: [
            Text(
              categoryData['name'],
              style: TextStyle(
                fontSize: size.height * 0.014,
                fontWeight: FontWeight.w300,
                color: ConstColor.greyColor,
              ),
            ),
            SizedBox(height: size.height * 0.005),
            Text(
              categoryData['value'],
              style: TextStyle(
                fontSize: size.height * 0.013,
                fontWeight: FontWeight.w600,
                color: ConstColor.black29Color,
              ),
            ),
          ],
        );
      },
    );
  }
}
