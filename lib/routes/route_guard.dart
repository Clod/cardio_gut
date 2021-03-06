import 'package:auto_route/auto_route.dart';
import 'package:cardio_gut/routes/router.gr.dart';
import 'package:cardio_gut/util/auth_service.dart';

class RouteGuard extends AutoRedirectGuard {
  final AuthService authService;
  RouteGuard(this.authService) {
    // Clod: This will trigger whenever there is a change in authentication state.
    // The developer does not have to explicitly check for authentication anywhere.
    authService.addListener(() {
      if (!authService.authenticated) {
        reevaluate();
      }
    });
  }

  @override
  Future<bool> canNavigate(RouteMatch route) async{
    return authService.authenticated;
  }

  // Clod: onNavigation() is called anytime navigation takes place
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {

    if (authService.authenticated) return resolver.next();
    // Clod: DONE: Navigate to login screen
    router.push(
      LoginRoute(
        onLoginCallback: (_) {
          // The resolver object has the data about where the user wanted to navigate
          // in case of deep-linking
          resolver.next();
          // Clod: Remove this login screen from our navigation stack, so when
          // user presses the back button they are not taken to a login screen again.
          router.removeLast();
        },
      ),
    );

  }

  // @override
  // dynamic noSuchMethod(Invocation invocation) {
  //   super.noSuchMethod(invocation);
  //   debugPrint("No such method");
  // }
}