class ApiUrls {
  //static String baseUrl = 'http://localhost:8000'; // For IOS
  static String baseUrl = 'http://10.0.2.2:8000'; // For Android

  static String loginEndpoint = '/auth/login/';
  static String signupEndpoint = '/auth/signup/';
  static String clubsEndpoint = '/clubs/'; 
  static String joinClubEndpoint = '/join-club/';  // Endpoint to join a club
  static String leaveClubEndpoint = '/leave-club/';  // Endpoint to leave a club
  static String myClubsEndpoint = '/my-clubs/';  // Endpoint to fetch clubs that the user has joined
  static String myEventsEndpoint = '/user-events/';
  static String removeEventEndpoint = '/unattend-event/';
  static String getClubEvents(int clubId) => '/club-events/$clubId/';
  static String attendEvent(int eventId) => '/attend-event/$eventId/';  // New method to generate the URL for attending an event
}