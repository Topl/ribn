import 'package:flutter/material.dart';
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/colors.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/constants/styles.dart';
import 'package:ribn/containers/mint_input_container.dart';
import 'package:ribn/widgets/address_display_container.dart';
import 'package:ribn/widgets/custom_page_title.dart';
import 'package:ribn/widgets/custom_text_field.dart';
import 'package:ribn/widgets/fee_info.dart';
import 'package:ribn/widgets/large_button.dart';
import 'package:ribn/widgets/loading_spinner.dart';
import 'package:ribn/widgets/note_text_field.dart';

/// The mint input page that allows the initiation of an mint asset transaction.
class MintInputPage extends StatefulWidget {
  const MintInputPage({Key? key}) : super(key: key);

  @override
  _MintInputPageState createState() => _MintInputPageState();
}

class _MintInputPageState extends State<MintInputPage> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _assetLongNameController = TextEditingController();
  final TextEditingController _assetShortNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    _controllers = [
      _noteController,
      _assetLongNameController,
      _assetShortNameController,
      _amountController,
    ];
    _controllers.forEach(initListener);
    super.initState();
  }

  @override
  void dispose() {
    _controllers.forEach(disposeController);
    super.dispose();
  }

  initListener(TextEditingController controller) {
    controller.addListener(() {
      setState(() {});
    });
  }

  disposeController(TextEditingController controller) {
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MintInputContainer(
      builder: (BuildContext context, MintInputViewmodel vm) => Scaffold(
        backgroundColor: RibnColors.accent,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 45),
                    child: CustomPageTitle(title: Strings.mint),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 310,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInputItem(
                          Strings.assetLongName,
                          CustomTextField(
                            controller: _assetLongNameController,
                            hintText: Strings.assetLongNameHint,
                          ),
                        ),
                        Row(
                          children: [
                            _buildInputItem(
                              Strings.assetShortName,
                              CustomTextField(
                                width: 186,
                                controller: _assetShortNameController,
                                hintText: Strings.assetShortNameHint,
                              ),
                            ),
                            const Spacer(),
                            _buildInputItem(
                              Strings.amount,
                              CustomTextField(
                                width: 108,
                                controller: _amountController,
                                hintText: Strings.amountHint,
                              ),
                            ),
                          ],
                        ),
                        _buildInputItem(
                          Strings.issuerAddress,
                          const AddressDisplayContainer(
                            text: Strings.yourIssuerAddress,
                            asset: RibnAssets.issuerFingerprint,
                          ),
                        ),
                        _buildInputItem(
                          Strings.to,
                          const AddressDisplayContainer(
                            text: Strings.yourRibnWalletAddress,
                            asset: RibnAssets.myFingerprint,
                          ),
                        ),
                        _buildInputItem(
                          Strings.note,
                          NoteTextField(
                            noteController: _noteController,
                            noteLength: _noteController.text.length,
                          ),
                        ),
                        FeeInfo(fee: vm.networkFee),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                          child: LargeButton(
                            label: Strings.review,
                            onPressed: () {
                              vm.initiateTx(
                                _assetShortNameController.text,
                                _amountController.text,
                                _noteController.text,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            vm.loadingRawTx ? const LoadingSpinner() : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputItem(
    String itemLabel,
    Widget item,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Text(
              itemLabel,
              style: RibnTextStyles.extH4,
            ),
          ),
          const SizedBox(height: 8),
          item,
        ],
      ),
    );
  }
}
