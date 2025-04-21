part of '../../feature.dart';

class InstalledWalletShimmer extends ConsumerWidget {
  final String title;
  final Widget icon;
  const InstalledWalletShimmer(
      {super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.secondary.withAlpha(50),
      highlightColor: Theme.of(context).colorScheme.secondary.withAlpha(51),
      child: InstalledWalletWidget(
        title: title,
        icon: icon,
        isInstalled: false,
        onTap: () {},
      ),
    );
  }
}
