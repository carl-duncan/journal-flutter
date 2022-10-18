// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/cupertino.dart';
import 'package:journal/app/app.dart';
import 'package:journal/bootstrap.dart';

import 'package:journal/integrations/amplify/amplify_configure.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AmplifyConfigure.configureAmplify();
  await bootstrap(() => const App());
}
