enum DataConnectionStatus{
  disconnected,
  connected,
}

class DataConnectionCheck{

  static const int DEFAULT_PORT=53;

  static const Duration DEFAULT_TIMEOUT=const Duration(seconds: 10);

  static const Duration DEFAULT_INTERVAL=const Duration(seconds: 10);


}