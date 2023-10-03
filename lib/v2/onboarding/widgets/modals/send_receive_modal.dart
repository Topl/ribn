import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ribn/v2/receive_assets/screens/receive_asset_screen.dart';
import 'package:ribn/v2/send_assets/screens/send_asset_screen.dart';
import 'package:ribn/v2/shared/constants/strings.dart';
import 'package:vrouter/vrouter.dart';
import '../../../asset_managment/widgets/asset_footer/asset_bottom_nav.dart';
import '../../../shared/constants/assets.dart';

class SendReceiveModal extends HookConsumerWidget {
  const SendReceiveModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.transparent,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.96),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 0),
                    onPressed: () {
                      context.vRouter.to(SendAssetScreen().route);
                    },
                    child: ListTile(
                      tileColor: Colors.white,
                      leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFE7E8E8)), borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(Assets.send),
                          )),
                      title: Text(
                        Strings.send,
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        'Send Tokens to another Wallet',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white, elevation: 0),
                    onPressed: () {
                      context.vRouter.to(ReceiveAssets().route);
                    },
                    child: ListTile(
                      tileColor: Colors.white,
                      leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFE7E8E8)), borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(Assets.received),
                          )),
                      title: Text(
                        Strings.receive,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text("Receive Tokens from another Wallet"),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(child: AssetBottomNavigation()),
                ],
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 2 - 28,
                bottom: 35,
                child: FloatingActionButton(
                  backgroundColor: Color(0XFF0DC8D4),
                  child: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
