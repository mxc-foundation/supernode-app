import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'action.dart';
import 'state.dart';

bool _searchMatch(BuildContext ctx, Currency value, String search) {
  return (search == null || search == '') ||
      (value.shortName + ' - ' + FlutterI18n.translate(ctx, value.shortName))
          .toUpperCase()
          .contains(search.toUpperCase());
}

Widget buildView(
    CalculatorListState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  final selectedCurrencies = state.selectedCurrencies
      .where((e) => _searchMatch(_ctx, e, state.searchValue))
      .where((e) => e != Currency.mxc)
      .toList();
  final fiatCurrencies = state.fiatCurrencies
      .where((e) => !state.selectedCurrencies.contains(e))
      .where((e) => _searchMatch(_ctx, e, state.searchValue))
      .toList();
  final cryptoCurrencies = state.cryptoCurrencies
      .where((e) => !state.selectedCurrencies.contains(e))
      .where((e) => _searchMatch(_ctx, e, state.searchValue))
      .toList();

  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: SafeArea(
      child: Container(
        constraints: BoxConstraints.expand(),
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        decoration: BoxDecoration(
          color: ColorsTheme.of(_ctx).primaryBackground,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(_ctx).size.height - 20),
          decoration: BoxDecoration(
            color: ColorsTheme.of(_ctx).boxComponents,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: boxShadowColor,
                offset: Offset(0, 2),
                blurRadius: 7,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: pageNavBar(
                  FlutterI18n.translate(_ctx, 'currencies'),
                  onTap: () => dispatch(
                    CalculatorListActionCreator.onDone(),
                  ),
                  actionWidget: Text(FlutterI18n.translate(_ctx, 'done')),
                  leadingWidget: GestureDetector(
                    key: ValueKey('navBackButton'),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: ColorsTheme.of(_ctx).textPrimaryAndIcons,
                    ),
                    onTap: () => Navigator.of(_ctx).pop(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (state.selectedCurrencies != null)
                Expanded(
                  flex: 1,
                  child: CustomScrollView(
                    key: ValueKey('currenciesScrollView'),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 20,
                          ),
                          child: TextField(
                            key: ValueKey('searchField'),
                            controller: state.searchController,
                            decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                  color: ColorsTheme.of(_ctx).textLabel,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.2),
                                ),
                              ),
                              hintText: FlutterI18n.translate(_ctx, 'search'),
                              hintStyle: TextStyle(fontSize: 12),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: _Title(
                            FlutterI18n.translate(_ctx, 'my_currencies')),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, i) => ListTile(
                            key: ValueKey(
                                'selected_${selectedCurrencies[i].shortName}'),
                            leading:
                                Image.asset(selectedCurrencies[i].iconPath),
                            title: Text(
                              FlutterI18n.translate(
                                _ctx,
                                selectedCurrencies[i].shortName,
                              ),
                            ),
                            trailing: Icon(
                              Icons.check,
                              color: ColorsTheme.of(_ctx).textPrimaryAndIcons,
                            ),
                            onTap: () => dispatch(
                              CalculatorListActionCreator.selectCurrency(
                                  selectedCurrencies[i]),
                            ),
                          ),
                          childCount: selectedCurrencies.length,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: _Title(
                            FlutterI18n.translate(_ctx, 'fiat_currencies')),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, i) => ListTile(
                            key:
                                ValueKey('fiat_${fiatCurrencies[i].shortName}'),
                            leading: Image.asset(fiatCurrencies[i].iconPath),
                            title: Text(
                              FlutterI18n.translate(
                                _ctx,
                                fiatCurrencies[i].shortName,
                              ),
                            ),
                            onTap: () => dispatch(
                              CalculatorListActionCreator.selectCurrency(
                                fiatCurrencies[i],
                              ),
                            ),
                          ),
                          childCount: fiatCurrencies.length,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: _Title(
                            FlutterI18n.translate(_ctx, 'cryptocurrencies')),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, i) => ListTile(
                            key: ValueKey(
                                'crypto_${cryptoCurrencies[i].shortName}'),
                            leading: Image.asset(cryptoCurrencies[i].iconPath),
                            title: Text(
                              FlutterI18n.translate(
                                _ctx,
                                cryptoCurrencies[i].shortName,
                              ),
                            ),
                            onTap: () => dispatch(
                              CalculatorListActionCreator.selectCurrency(
                                cryptoCurrencies[i],
                              ),
                            ),
                          ),
                          childCount: cryptoCurrencies.length,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _Title extends StatelessWidget {
  final String text;
  _Title(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: EdgeInsets.only(left: 16),
      color: ColorsTheme.of(context).primaryBackground,
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 12),
      ),
    );
  }
}
