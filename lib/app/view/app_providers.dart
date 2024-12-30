part of 'view.dart';

class AppCoreProviders extends StatelessWidget {
  const AppCoreProviders({
    super.key,
    this.fcmToken = '',
  });

  final String fcmToken;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HttpClient>(
          create: (context) => HttpClientImpl(),
        ),
      ],
      child: const AppView(),
    );
  }
}
