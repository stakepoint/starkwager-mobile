part of '../../feature.dart';

class InstalledWalletShimmer extends ConsumerWidget {
  final String title;
  final Widget icon;
  const InstalledWalletShimmer({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
      highlightColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
      child: InstalledWalletWidget(
        title: title,
        icon: icon,
        isInstalled: false,
        onTap: () {},
      ),
    );
  }
}
