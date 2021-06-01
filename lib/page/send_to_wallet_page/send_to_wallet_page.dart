import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/colored_text.dart';
import 'package:supernodeapp/common/components/pagination_mixin.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/slider.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/wallet.model.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/parser.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/common/utils/extensions.dart';
import 'confirm_page.dart';
import 'filter_dialog.dart';
import 'proceed_dialog.dart';

class SendToWalletPage extends StatefulWidget {
  const SendToWalletPage({
    Key key,
  }) : super(key: key);

  @override
  _SendToWalletPageState createState() => _SendToWalletPageState();
}

class _SendToWalletPageState extends State<SendToWalletPage>
    with PaginationMixin {
  @override
  final scrollController = ScrollController();
  @override
  bool isLoading = false;
  @override
  bool get hasDataToLoad {
    if (forceStopLoading) return false;
    if (totalGateways == null) return true;
    return totalGateways > allGateways?.length;
  }

  int totalGateways;
  List<GatewayItem> allGateways;
  List<GatewayItem> gateways;
  Map<String, GatewayItem> gatewaysMap;
  bool forceStopLoading = false;
  Map<String, double> gatewaySelection = {};

  @override
  Future<void> load({bool noLimit = false}) async {
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
    try {
      final supernodeRepository = context.read<SupernodeRepository>();
      final orgId = context.read<SupernodeCubit>().state.orgId;
      final res = await supernodeRepository.gateways.list({
        "organizationID": orgId,
        "offset": gateways?.length ?? 0,
        "limit": noLimit ? 10000000 : 10,
      });
      final listMinersHealth = await supernodeRepository.gateways.minerHealth({
        "orgId": orgId,
      });
      totalGateways = int.parse(res['totalCount']);
      final newGateways = parseGateways(res, listMinersHealth);
      if (newGateways.isEmpty) forceStopLoading = true;
      if (mounted)
        setState(() {
          isLoading = false;
          allGateways = [...(allGateways ?? <GatewayItem>[]), ...newGateways];
          gateways = allGateways
              .where(
                  (e) => e.miningFuel > Decimal.zero && e.miningFuelHealth != 0)
              .toList();
          gatewaysMap =
              gateways.asMap().map((key, value) => MapEntry(value.id, value));
        });
    } finally {
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Widget addFuelMessage() => Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Image.asset(AppImages.fuelCircle),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  FlutterI18n.translate(context, 'send_to_wallet'),
                  style: kBigBoldFontOfBlack,
                ),
                Text(
                  FlutterI18n.translate(context, 'send_to_wallet_desc'),
                ),
              ],
            ),
          ),
        ],
      );

  Widget selectAll() => Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade200, width: 0.5),
            bottom: BorderSide(color: Colors.grey.shade200, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                FlutterI18n.translate(context, 'add_all'),
                textAlign: TextAlign.right,
                style: kBigFontOfBlack,
              ),
            ),
            SizedBox(width: 5),
            Switch(
              value: gateways != null &&
                  gateways.length > 0 &&
                  gatewaySelection.length >= gateways.length &&
                  !hasDataToLoad &&
                  gatewaySelection.values.every((e) => e == 1),
              onChanged: (v) {
                if (v)
                  fuelAll();
                else
                  defaultAll();
              },
              inactiveThumbColor: Colors.grey.shade700,
              activeColor: healthColor,
            ),
          ],
        ),
      );

  Widget gatewayItem(GatewayItem item) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => gatewaySelection[item.id] = 0),
                    child: Padding(
                      padding: EdgeInsets.only(left: 13, right: 4, top: 3),
                      child: Icon(
                        Icons.check,
                        size: 18,
                        color: (gatewaySelection[item.id] ?? 0) > 0
                            ? healthColor
                            : Colors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.name,
                      style: kBigFontOfBlack,
                    ),
                  ),
                  Image.asset(
                    AppImages.gateways,
                    height: 16,
                    color: colorMxc,
                  ),
                  SizedBox(width: 6),
                  Text(
                    '${Tools.priceFormat((item.health ?? 0) * 100, range: 0)}%',
                    style: kBigFontOfBlack,
                  ),
                  SizedBox(width: 18),
                  Image.asset(
                    AppImages.fuel,
                    color: fuelColor,
                    height: 16,
                  ),
                  SizedBox(width: 6),
                  Text(
                    '${Tools.priceFormat((item.miningFuelHealth ?? 0) * 100, range: 0)}%',
                    style: kBigFontOfBlack,
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 30,
                child: MxcSliderTheme(
                  child: Slider(
                    value: gatewaySelection[item.id] ?? 0,
                    onChanged: (v) =>
                        setState(() => gatewaySelection[item.id] = v),
                    activeColor: healthColor,
                    inactiveColor: healthColor.withOpacity(0.2),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                SizedBox(width: 16),
                Text(FlutterI18n.translate(context, 'current_fuel'),
                    style: kSmallFontOfGrey),
                Text(
                  '${Tools.priceFormat(item.miningFuel.toDouble(), range: 2)} MXC',
                  style: kSmallFontOfBlack.copyWith(color: healthColor),
                ),
                Spacer(),
                ColoredText(
                  text:
                      '${Tools.priceFormat(item.miningFuel.toDouble() * (gatewaySelection[item.id] ?? 0), range: 2)} MXC',
                  color: healthColor.withOpacity(0.2),
                  style: kMiddleFontOfBlack,
                  padding: EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
          ],
        ),
      );

  Future<void> fuelAll() async {
    await load(noLimit: true);
    gateways.forEach((e) => gatewaySelection[e.id] = 1);
    if (mounted) setState(() {});
  }

  void defaultAll() {
    gateways.forEach((e) => gatewaySelection[e.id] = 0);
    if (mounted) setState(() {});
  }

  void onFilter() {
    showInfoDialog(
      context,
      filterDialog(),
    );
  }

  Future<void> onNext(BuildContext context) async {
    final res = await showCupertinoModalPopup(
          context: context,
          builder: (ctx) => proceedDialog(ctx, withdrawMxc),
        ) ??
        false;
    if (res) {
      final orgId = context.read<SupernodeCubit>().state.orgId;
      final rep = context.read<SupernodeRepository>();
      final withdraws =
          gatewaySelection.entries.where((e) => e.value > 0).map((e) {
        var val =
            (gatewaysMap[e.key].miningFuel.toDouble() * e.value).toString();
        if (gatewaysMap[e.key].miningFuel < Decimal.parse(val))
          val = gatewaysMap[e.key].miningFuel.toString();

        return GatewayAmountRequest(
          val,
          e.key,
        );
      }).toList();

      final res = await rep.wallet
          .withdrawMiningFuel(
              currency: 'ETH_MXC', orgId: orgId, withdraws: withdraws)
          .withError();

      if (res.success) {
        await Navigator.of(context)
            .push(route((ctx) => SendToWalletConfirmPage()));
      } else {
        await Navigator.of(context).push(
          route((ctx) => SendToWalletConfirmPage(error: res.error)),
        );
      }
    }
  }

  double get withdrawMxc {
    var total = 0.0;
    gatewaySelection.forEach((key, value) =>
        total += gatewaysMap[key].miningFuel.toDouble() * value);
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.backArrowAndActionAppBar(
        // action: IconButton(
        //   icon: Icon(
        //     Icons.filter_list,
        //   ),
        //   onPressed: onFilter,
        //   color: Colors.black,
        // ),
        title: FlutterI18n.translate(context, 'send_to_wallet'),
        onPress: () => Navigator.of(context).pop(),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      addFuelMessage(),
                      SizedBox(height: 19),
                      selectAll(),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => gatewayItem(gateways[i]),
                    childCount: gateways?.length ?? 0,
                  ),
                ),
                if (gateways?.isEmpty ?? false)
                  SliverFillRemaining(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        right: 46,
                        left: 46,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          FlutterI18n.translate(
                              context, 'send_to_wallet_dont_have_miners'),
                          textAlign: TextAlign.center,
                          style: kMiddleFontOfGrey,
                        ),
                      ),
                    ),
                  )
                else if (isLoading && gateways == null)
                  SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(healthColor),
                        backgroundColor: healthColor.withOpacity(0.2),
                      ),
                    ),
                  )
                else if (isLoading)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(healthColor),
                          backgroundColor: healthColor.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Container(height: 0.5, color: Colors.grey.shade200),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    '${Tools.priceFormat(withdrawMxc, range: 2)} MXC',
                    style: kVeryBigFontOfBlack.copyWith(color: healthColor),
                  ),
                ),
                SizedBox(height: 9),
                Center(
                  child: Text(
                    FlutterI18n.translate(context, 'send_amount'),
                    style: kMiddleFontOfGrey,
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: PrimaryButton(
                      onTap: () => onNext(context),
                      minHeight: 46,
                      buttonTitle: FlutterI18n.translate(context, 'next'),
                      bgColor: healthColor,
                      minWidth: 0,
                      textStyle: kBigFontOfWhite,
                    ),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}