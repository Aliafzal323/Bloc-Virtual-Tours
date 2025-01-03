part of 'view.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selection Page'),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _VirtualToursWidget(),
            SizedBox(
              height: 20,
            ),
            _VideoPlayerWidget(),
            SizedBox(
              height: 20,
            ),
            _PaginationPageWidget(),
          ],
        ),
      ),
    );
  }
}

class _VideoPlayerWidget extends StatelessWidget {
  const _VideoPlayerWidget();

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const VideoPlayerPage()));
      },
      child: const CustomListTileWidget(
        title: 'Video Player Page',
        subTitle: 'Click to play video player ',
        icon: AssetIcons.video,
      ),
    );
  }
}

class _VirtualToursWidget extends StatelessWidget {
  const _VirtualToursWidget();

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const VirtualToursPage()));
      },
      child: const CustomListTileWidget(
        title: 'Virtual Tours Page',
        subTitle: 'Click to view virtual Tours',
        icon: AssetIcons.virtual_tour,
      ),
    );
  }
}

class _PaginationPageWidget extends StatelessWidget {
  const _PaginationPageWidget();

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PaginationPage()));
      },
      child: const CustomListTileWidget(
        title: 'Pagination Page',
        subTitle: 'Click to view pagination of list',
        icon: AssetIcons.virtual_tour,
      ),
    );
  }
}
