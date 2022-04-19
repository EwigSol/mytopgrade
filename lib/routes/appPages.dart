

abstract class Routes {
  Routes._();
  static const initial = Paths.initial;
  static const splash = Paths.splash;
  static const login = Paths.login;
  static const register = Paths.register;
  static const forgotPass = Paths.forgotPass;
  static const home = Paths.home;
}

abstract class Paths {
  Paths._();
  static const initial = '/';
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const forgotPass = '/forgotPass';
  static const home = '/home';
}