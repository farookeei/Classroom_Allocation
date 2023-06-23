import 'env_abstract.dart';

class TestConfig implements BaseConfig {
  @override
  String get apiHost => "https://nibrahim.pythonanywhere.com";
}

class DevConfig implements BaseConfig {
  @override
  String get apiHost => "https://nibrahim.pythonanywhere.com";
}

//?BETA
class StagingConfig implements BaseConfig {
  @override
  String get apiHost => "https://nibrahim.pythonanywhere.com";
}

class ProdConfig implements BaseConfig {
  @override
  String get apiHost => "https://nibrahim.pythonanywhere.com";
}
