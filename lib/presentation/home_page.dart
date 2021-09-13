import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ribn/constants/keys.dart';
import 'package:ribn/constants/routes.dart';
import 'package:ribn/constants/rules.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/home_container.dart';
import 'package:ribn/presentation/address_section.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeContainer(
      builder: (context, vm) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [_buildSettingsMenu()],
          ),
          body: Column(
            children: [
              _buildDisplayAddress(vm.displayAddress),
              const SizedBox(height: 11),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '0 Polys',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
              ),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    const SizedBox(),
                    const SizedBox(),
                    AddressSection(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSettingsMenu() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: _onSelected,
      itemBuilder: (BuildContext context) {
        return Rules.settings.map(
          (String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),
            );
          },
        ).toList();
      },
    );
  }

  Widget _buildDisplayAddress(String displayAddr) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.5,
        ),
        child: MaterialButton(
          onPressed: () => Clipboard.setData(ClipboardData(text: displayAddr)),
          child: Tooltip(
            message: Strings.copyToClipboard,
            child: Text(
              displayAddr,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
                overflow: TextOverflow.ellipsis,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      isScrollable: false,
      controller: _tabController,
      automaticIndicatorColorAdjustment: true,
      tabs: const [
        Tab(child: Text(Strings.activity)),
        Tab(child: Text(Strings.send)),
        Tab(child: Text(Strings.receive)),
      ],
    );
  }

  void _onSelected(String choice) {
    switch (choice) {
      case Strings.logout:
        {
          Keys.navigatorKey.currentState!.pushNamedAndRemoveUntil(Routes.login, (route) => false);
          break;
        }
      default:
        break;
    }
  }
}
