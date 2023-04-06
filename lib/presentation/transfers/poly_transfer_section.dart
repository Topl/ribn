// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:ribn/constants/network_utils.dart';
import 'package:ribn_toolkit/constants/colors.dart';
import 'package:ribn_toolkit/constants/styles.dart';
import 'package:ribn_toolkit/widgets/atoms/large_button.dart';
import 'package:ribn_toolkit/widgets/molecules/asset_amount_field.dart';
import 'package:ribn_toolkit/widgets/molecules/note_field.dart';
import 'package:ribn_toolkit/widgets/molecules/recipient_field.dart';

// Project imports:
import 'package:ribn/constants/assets.dart';
import 'package:ribn/constants/network_utils.dart';
import 'package:ribn/constants/strings.dart';
import 'package:ribn/containers/poly_transfer_input_container.dart';
import 'package:ribn/presentation/transfers/bottom_review_action.dart';
import 'package:ribn/presentation/transfers/transfer_utils.dart';
import 'package:ribn/presentation/transfers/widgets/custom_input_field.dart';
import 'package:ribn/presentation/transfers/widgets/from_address_field.dart';
import 'package:ribn/providers/transactions/poly_transfer_provider.dart';
import 'package:ribn/widgets/address_display_container.dart';
import 'package:ribn/widgets/fee_info.dart';

/// The input page that allows initiating poly transfer transaction.
///
/// Builds the necessary input fields needed for a poly transfer.
// ignore: must_be_immutable
class PolyTransferSection extends HookConsumerWidget {
  PolyTransferInputViewModel vm;
  final Function updateButton;

  PolyTransferSection({
    required this.vm,
    required this.updateButton,
    Key? key,
  }) : super(key: key);

  final GlobalKey _formKey = GlobalKey<FormState>();

  // TODO, Update this so that it's not causing a render in another widget
  void renderBottomButton() {
    return WidgetsBinding.instance.addPostFrameCallback((_) {
      updateButton(
        BottomReviewAction(
          maxHeight: kIsWeb ? 120 : 150,
          children: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // fee info for the tx
              FeeInfo(
                fee: vm.networkFee,
                currentNetworkName: vm.currentNetwork.networkName,
              ),
              _ReviewButton(
                vm: vm,
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Have to keep watch here otherwise the controller will dispose
    // ignore: unused_local_variable
    final polyTransfer = ref.watch(polyTransferProvider);
    final polyTransferNotifier = ref.watch(polyTransferProvider.notifier);
    final _recipientController = useTextEditingController();
    final _noteController = useTextEditingController();

    useEffect(() {
      renderBottomButton();
      return null;
    }, []);

    return Column(
      children: [
        SizedBox(
          width: 310,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // UI to indicate poly transfer
                _PolyDisplay(
                  vm: vm,
                ),
                // field for entering amount of polys needed for transfer
                _AmountField(
                  vm: vm,
                ),
                // field for displaying the sender addresses
                const FromAddressField(),
                // field for entering the recipient address
                RecipientField(
                  controller: _recipientController,
                  validRecipientAddress: polyTransfer.validRecipientAddress,
                  // validate the address entered on text change
                  onChanged: (recipient) {
                    polyTransferNotifier.validateRecipient(recipient, vm.currentNetwork, _recipientController);
                  },
                  onBackspacePressed: () {
                    polyTransferNotifier.onRecipientBackspacePressed(_recipientController);
                  },
                  icon: SvgPicture.asset(RibnAssets.recipientFingerprint),
                  alternativeDisplayChild: const AddressDisplayContainer(
                    text: Strings.yourRibnWalletAddress,
                    icon: RibnAssets.myFingerprint,
                    width: 250,
                  ),
                ),
                // field for adding a note to the tx
                NoteField(
                  controller: _noteController,
                  noteLength: _noteController.text.length,
                  tooltipIcon: Image.asset(
                    RibnAssets.greyHelpBubble,
                    width: 18,
                  ),
                  onChanged: (String note) {
                    polyTransferNotifier.updateNote(note);
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

/// Builds the UI for indicating poly transfer.
class _PolyDisplay extends StatelessWidget {
  final PolyTransferInputViewModel vm;
  const _PolyDisplay({
    required this.vm,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isValhalla = vm.currentNetwork.networkName == NetworkUtils.valhalla;
    return CustomInputField(
      itemLabel: Strings.sending,
      item: Container(
        width: 310,
        height: 36,
        decoration: BoxDecoration(
          color: RibnColors.whiteBackground,
          border: Border.all(
            color: const Color(0xffE9E9E9),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(4.7),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: Image.asset(RibnAssets.polysIcon),
            ),
            Text('${isValhalla ? 'nanoPOLY' : 'POLY'}'),
          ],
        ),
      ),
    );
  }
}

/// Builds the TextField for entering amount needed for the transfer.
class _AmountField extends HookConsumerWidget {
  final PolyTransferInputViewModel vm;

  const _AmountField({
    required this.vm,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amountController = useTextEditingController();
    final maxPolys = vm.maxTransferrableAmount;

    return AssetAmountField(
      controller: amountController,
      maxTransferrableAmount: maxPolys,
      errorString: Strings.overMaxPolys(maxPolys.toInt()),
      selectedUnit: 'POLY',
      onChanged: (String amount) {
        ref.read(polyTransferProvider.notifier).updateAmount(amount);
      },
    );
  }
}

class _ReviewButton extends HookConsumerWidget {
  final PolyTransferInputViewModel vm;

  const _ReviewButton({
    required this.vm,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final polyTransfer = ref.watch(polyTransferProvider);

    bool _validAmount = TransferUtils.validateAmount(
      polyTransfer.amount,
      vm.maxTransferrableAmount,
    );
    final bool enteredValidInputs =
        polyTransfer.validRecipientAddress.isNotEmpty && polyTransfer.amount > 0 && _validAmount;

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Center(
        child: LargeButton(
          buttonWidth: double.infinity,
          buttonChild: Text(
            Strings.review,
            style: RibnToolkitTextStyles.btnLarge.copyWith(
              color: Colors.white,
            ),
          ),
          onPressed: enteredValidInputs
              ? () {
                  context.loaderOverlay.show();
                  vm.initiateTx(
                    amount: polyTransfer.amount.toString(),
                    recipient: polyTransfer.recipientAddress,
                    note: polyTransfer.note,
                    onRawTxCreated: (bool success) async {
                      context.loaderOverlay.hide();
                      // Display error dialog if failed to create raw tx
                      if (!success) {
                        await TransferUtils.showErrorDialog(context);
                      }
                    },
                  );
                }
              : () {},
          disabled: !enteredValidInputs,
        ),
      ),
    );
  }
}
