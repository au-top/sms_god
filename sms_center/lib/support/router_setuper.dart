import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'router_method_enum.dart';
import 'router_prefix_match.dart';

Router buildRouter({
  List<Handler>? middleware,
  Map<String, Router>? children,
  Map<HttpMethods, List<Handler>>? on,
}) {
  final newCreateRouter = Router();
  middleware ??= [];
  children ??= {};
  on ??= {};

  /// setup middleware
  for (var middleware in middleware) {
    newCreateRouter.all("/${RouterPrefixMatch.middleware}", middleware);
  }

  /// mount other router
  for (var childrenItem in children.entries) {
    newCreateRouter.mount(childrenItem.key, childrenItem.value);
  }

  for (var onEntries in on.entries) {
    for (var onHandler in onEntries.value) {
      newCreateRouter.add(routerMethodsEnum.toValue(onEntries.key)!, "/", onHandler);
    }
  }

  return newCreateRouter;
}
