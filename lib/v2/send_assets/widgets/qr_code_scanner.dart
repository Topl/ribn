import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart'; // Import flutter_hooks
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vrouter/vrouter.dart';

class QRViewScanner extends HookWidget {
  // Use HookWidget instead of StatefulWidget
  @override
  Widget build(BuildContext context) {
    final result = useState<Barcode?>(null); // Use useState hook
    final qrKey = GlobalKey(debugLabel: 'QR');

    final scanArea =
        (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;

    void _onQRViewCreated(QRViewController controller) {
      controller.scannedDataStream.listen((scanData) {
        result.value = scanData; // Update the result using the state hook
      });
    }

    void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
      if (!p) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('no Permission')),
        );
      }
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: scanArea,
              ),
              onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
            ),
          ),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result.value != null)
                    Text('Barcode Type: ${describeEnum(result.value!.format)}   Data: ${result.value!.code}')
                  else
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: const Text('Scan a code'),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () {
                            context.vRouter.historyBack();
                          },
                          child: const Text('Back', style: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
