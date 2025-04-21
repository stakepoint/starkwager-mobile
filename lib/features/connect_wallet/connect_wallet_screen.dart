part of '../feature.dart';

class ConnectWalletScreen extends ConsumerStatefulWidget {
  const ConnectWalletScreen({super.key});

  @override
  ConsumerState<ConnectWalletScreen> createState() => _ConnectWalletScreen();
}

class _ConnectWalletScreen extends ConsumerState<ConnectWalletScreen> {
  ReownAppKitModal? w3mService;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
        (_) => ref.read(walletConnectionProvider.notifier).initialize(context));
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<WalletConnectionState>(walletConnectionProvider, (previous, next) async {
      if (next is WalletConnected) {
        final chainId = next.service.selectedChain!.chainId;
        final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
          chainId,
        );
        final address = next.service.session!.getAddress(namespace)!;

        // Call create login endpoint with this address and trigger AuthLoading state
        await ref.read(authNotifierProvider.notifier).createLoginWithAddress(address);
        // Optionally, navigate to profile setup screen after login
        //Navigator.of(context).pushReplacementNamed('/profile-setup', arguments: address);
      }
    });
    final argent = ref.watch(argentCheckProvider);
    final braavos = ref.watch(braavosCheckProvider);
    final metamask = ref.watch(metamaskCheckProvider);
    final walletState = ref.watch(walletConnectionProvider);
    final authState = ref.watch(authNotifierProvider);

    if (walletState is WalletConnected) {
      w3mService = walletState.service;
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppValues.padding16),
            child: GestureDetector(
                onTap: () {
                  context.isMobile
                      ? GoRouter.of(context).go(Routes.profileSetup)
                      : GoRouter.of(context).go(Routes.profileSetup);
                },
                child: SvgPicture.asset(AppIcons.hamburgerIcon)),
          )
        ],
        automaticallyImplyLeading: false,
        backgroundColor: context.primaryBackgroundColor,
        foregroundColor: context.primaryTextColor,
      ),
      backgroundColor: context.primaryBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double maxWidth = AppValues.width600;
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppValues.padding16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(AppValues.height60),
                      Text('welcomeToStarkWager'.tr(),
                          style: AppTheme.of(context).headLineLarge32),
                      verticalSpace(AppValues.height8),
                      Row(
                        children: [
                          Text('connectYourWalletToUse'.tr(),
                              style: AppTheme.of(context).bodyExtraLarge18),
                          horizontalSpace(AppValues.padding3),
                          Text(
                            'starkWager'.tr(),
                            style: AppTheme.of(context)
                                .bodyExtraLarge18
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      verticalSpace(AppValues.height30),
                      verticalDivider(color: context.dividerColor),
                      verticalSpace(AppValues.height30),
                      if (authState is AuthLoading) ...[
                        InstalledWalletShimmer(
                          title: 'Argent',
                          icon: Image.asset(AppIcons.argentIcon),
                        ),
                        verticalSpace(AppValues.height15),
                        InstalledWalletShimmer(
                          title: 'Braavos',
                          icon: Image.asset(AppIcons.braavosIcon),
                        ),
                        verticalSpace(AppValues.height15),
                        InstalledWalletShimmer(
                          title: 'Metamask',
                          icon: SvgPicture.asset(AppIcons.metaMaskIcon,
                              width: AppValues.width24,
                              height: AppValues.height24),
                        ),
                      ] else ...[
                        argent.when(
                            data: (isInstalled) => InstalledWalletWidget(
                                  title: 'Argent',
                                  icon: Image.asset(AppIcons.argentIcon),
                                  isInstalled: isInstalled,
                                  onTap: () {},
                                ),
                            error: (error, stack) => InstalledWalletWidget(
                                  title: 'Argent',
                                  icon: Image.asset(AppIcons.argentIcon),
                                  isInstalled: false,
                                  onTap: () {},
                                ),
                            loading: () => InstalledWalletShimmer(
                                  title: 'Argent',
                                  icon: Image.asset(AppIcons.argentIcon),
                                )),
                        verticalSpace(AppValues.height15),
                        braavos.when(
                            data: (isInstalled) => InstalledWalletWidget(
                                  title: 'Braavos',
                                  icon: Image.asset(AppIcons.braavosIcon),
                                  isInstalled: isInstalled,
                                  onTap: () {},
                                ),
                            error: (error, stack) => InstalledWalletWidget(
                                  title: 'Braavos',
                                  icon: Image.asset(AppIcons.braavosIcon),
                                  isInstalled: false,
                                  onTap: () {},
                                ),
                            loading: () => InstalledWalletShimmer(
                                  title: 'Braavos',
                                  icon: Image.asset(AppIcons.braavosIcon),
                                )),
                        verticalSpace(AppValues.height15),
                        metamask.when(
                            data: (isInstalled) => InstalledWalletWidget(
                                  title: 'Metamask',
                                  icon: SvgPicture.asset(AppIcons.metaMaskIcon,
                                      width: AppValues.width24,
                                      height: AppValues.height24),
                                  isInstalled: isInstalled,
                                  onTap: () {
                                    w3mService!.openModalView();
                                  },
                                ),
                            error: (error, stack) => InstalledWalletWidget(
                                  title: 'Metamask',
                                  icon: SvgPicture.asset(AppIcons.metaMaskIcon,
                                      width: AppValues.width24,
                                      height: AppValues.height24),
                                  isInstalled: false,
                                  onTap: () {
                                    w3mService!.openModalView();
                                  },
                                ),
                            loading: () => InstalledWalletShimmer(
                                  title: 'Metamask',
                                  icon: SvgPicture.asset(AppIcons.metaMaskIcon,
                                      width: AppValues.width24,
                                      height: AppValues.height24),
                                )),
                      ],
                      verticalSpace(AppValues.height15),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
