/*
 * Copyright 2022 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';

import 'package:journal/l10n/l10n.dart';

class LocalizedInputResolver extends InputResolver {
  const LocalizedInputResolver();

  /// Override the title function
  /// Since this function handles the title for numerous fields,
  /// we recommend using a switch statement so that `super` can be called
  /// in the default case.
  @override
  String title(BuildContext context, InputField field) {
    final l10n = AppLocalizations.of(context);
    // ignore: missing_enum_constant_in_switch
    switch (field) {
      case InputField.username:
        return l10n.username;
      case InputField.email:
        return l10n.email;
      case InputField.password:
        return l10n.password;
      case InputField.passwordConfirmation:
        return l10n.confirmPassword;
    }
    return super.title(context, field);
  }
}
