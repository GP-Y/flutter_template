const env = 'DEV'; //PROD

// 开发环境
const devHost = 'https://api.gigimed.cn';

// 生产环境
const prodHost = 'https://api.gigimed.cn';

class Config {
  static const apiUrl = (env == "DEV") ? devHost : prodHost;

  static bool isRelease = const bool.fromEnvironment("dart.vm.product");
}
