class ConstList {
  List<Map<String, dynamic>> typeOfCall = [
    {
      'name': 'All',
      'isSelected': false,
    },
    {
      'name': 'Buy',
      'isSelected': false,
    },
    {
      'name': 'Sell',
      'isSelected': false,
    },
  ];
  List<Map<String, dynamic>> targetParameterList = [
    {
      'name': 'Hit',
      'isSelected': false,
    },
    {
      'name': 'Missed',
      'isSelected': false,
    },
  ];
  List<Map<String, dynamic>> segmentList = [
    {
      'name': 'All',
      'type': 'all',
      'isSelected': false,
    },
    {
      'name': 'Cash',
      'type': 'NSECASH',
      'isSelected': false,
    },
    {
      'name': 'Futures',
      'type': 'NSEFUT',
      'isSelected': false,
    },
    {
      'name': 'Options',
      'type': 'NSECALL',
      'isSelected': false,
    },
  ];
  List<Map<String, dynamic>> categoryList = [
    {
      'name': 'All',
      'type': 'all',
    },
    {
      'name': 'Fundamental',
      'type': 'FUNDAMENTAL',
    },
    {
      'name': 'Technical',
      'type': 'TECHNICAL',
    },
    {
      'name': 'FnO',
      'type': 'FNO',
    },
  ];
  List<Map<String, dynamic>> durationList = [
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
  List<Map<String, dynamic>> orderTypeList = [
    {
      'name': 'Market',
      'isSelected': false,
      'type': 'Market',
    },
    {
      'name': 'Limit',
      'isSelected': false,
      'type': 'Limit',
    },
    {
      'name': 'SL Limit',
      'isSelected': false,
      'type': 'SL',
    },
    {
      'name': 'SL Market',
      'isSelected': false,
      'type': 'SL-M',
    },
  ];
}
