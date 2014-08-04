import 'package:polymer/builder.dart';

main(args) {
  lint(entryPoints: ['web/index.html'], options: parseOptions(args));
}
