import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../support/router_method_enum.dart';
import '../support/router_setuper.dart';

final helloworldController = buildRouter(
  middleware: [
    (Request request) {
      print("HelloWorld");
      return Router.routeNotFound;
    }
  ],
  on: {
    HttpMethods.GET: [
      (Request request) {
        return Response.ok("HelloWorld!");
      }
    ],
    HttpMethods.POST: [
      (Request request) {
        return Response.ok("HelloWorld!!!");
      }
    ],
  },
  children: {
    "/next": buildRouter(
      middleware: [
        (Request request) {
          print("routeNotFound");
          return Router.routeNotFound;
        },
      ],
      on: {
        HttpMethods.POST: [
          (Request request) {
            return Response.ok("HelloWorld");
          }
        ]
      },
    ),
  },
);
