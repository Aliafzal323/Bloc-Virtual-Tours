import 'package:common/common.dart';
import 'package:common/http/http_client.dart';
import 'package:common/http/http_client_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_tours_bloc/selection_view/selection_page.dart';

part 'app_providers.dart';
part 'app_view.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.unfocus(),
      child: const AppCoreProviders(),
    );
  }
}
