class ApiUrl {
  static const String _baseUrl = 'https://blinkx.live/api/';
  static const String _myConnectBaseUrl = 'https://myconnect.jmfonline.in/';
  static const String _eleverBaseUrl =
      'https://test.api.condor.elever.tech/v4/';
  static const String _eleverBaseUrlV0 =
      'https://test.api.condor.elever.tech/v0/';
  static const String _marketDataBaseUrl =
      'https://smartweb.jmfinancialservices.in/apimarketdata/';
  static const String sendOTPUrl = '${_baseUrl}user/authenticate/sendOtp';
  // static const String myconnectLogin = '${_myConnectBaseUrl}trading/v2/Login';
  static const String blinkXLogin = '${_myConnectBaseUrl}trading/v2/Login';
  static const String refreshTokenUrl =
      '${_myConnectBaseUrl}trading/v2/refresh-token';
  static const String allBasket =
      '${_eleverBaseUrl}basket/allbaskets?productgrpid=GGL02';
  static const String verifyOTPUrl = '${_baseUrl}user/authenticate/verifyOtp';
  static const String updateNameUrl = '${_baseUrl}user/profile/update?';
  static const String userProfile = '${_baseUrl}user/profile';

  //Orders
  static const String orderBookApi = '${_myConnectBaseUrl}trading/v2/OrderBook';
  static const String orderLimitsApi = '${_myConnectBaseUrl}trading/v2/Limits';
  static const String reqMarginApi =
      'https://dev-ws.deh.blink.trade/Middleware/RequiredMargin/GetDetails';
  static const String holdingsApi =
      '${_myConnectBaseUrl}trading/v2/GetHoldings';
  // static const String portfolioHoldingsApi =
  //     'https://dev-ws.deh.blink.trade/Middleware/Portfolio/GetHoldings';
  static const String portfolioHoldingsApi =
      'https://wsdeh.blinkx.in/Middleware/Portfolio/GetHoldings/Advisory';
  static const String netPositionsApi =
      '${_myConnectBaseUrl}trading/v2/GetNetPositions';
  static const String dayPositionsApi =
      '${_myConnectBaseUrl}trading/v2/GetDayPositions';
  static const String basketIntroApi =
      '${_eleverBaseUrl}basket/basketintro?productid=';
  static const String basketProposalApi =
      '${_eleverBaseUrl}landing/factors/factorproposal';
  static const String investBasketApi =
      '${_eleverBaseUrl}landing/basket/investinbasket';
  static const String placeTradeApi =
      '${_eleverBaseUrl}landing/orders/placetrade';
  static const String investSummaryApi =
      '${_eleverBaseUrl}landing/trackers/investsummary';
  static const String basketDashboardApi =
      '${_eleverBaseUrl}landing/trackers/dashboard';
  static const String eleverPostTradeApi =
      '${_eleverBaseUrlV0}maintenance/elevergatewayorderpost';
  static const String placeOrderApi =
      '${_myConnectBaseUrl}trading/v2/PlaceOrder';
  static const String cancelOrderApi =
      '${_myConnectBaseUrl}trading/v2/CancelOrder';

  // profile
  static const String userProfileApi =
      '${_myConnectBaseUrl}trading/v2/GetProfile';

  //Advisor
  static const String advisorCallsApi = '${_baseUrl}advisory/advisor-calls';
  static const String advisorListApi = '${_baseUrl}advisory/advisor/list';
  static const String advisorByIdApi = '${_baseUrl}advisory/advisor/';
  static const String followAdvisorApi = '${_baseUrl}advisory/advisor/follow';

  //Home
  static const String quoteApi = '${_baseUrl}advisory/data/quote/nifty50';
  // static const String quoteApi = '${_baseUrl}advisory/data/quote';

  // instrument quote
  static const String firstTokenApi =
      '${_marketDataBaseUrl}common/getaccesstoken';
  static const String secondTokenApi =
      '${_marketDataBaseUrl}auth/generatetoken';
  static const String clientConfigAPi =
      '${_marketDataBaseUrl}config/clientConfig';
  static const String instrumentsQuoteAPi =
      '${_marketDataBaseUrl}instruments/quotes';

  //user
  static const String getDetailsApi =
      'https://blinkxadvisory.appspot.com/getDetails';
}
