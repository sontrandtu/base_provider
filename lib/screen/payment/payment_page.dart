import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/sys/base_state.dart';
import 'package:achitecture_weup/common/core/widget/form_album.dart';
import 'package:achitecture_weup/screen/payment/payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends BaseState<PaymentPage, PaymentViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComp(title: 'App'),
      body: ChangeNotifierProvider.value(
        value: viewModel,
        child: const _PaymentLayout(),
      ),
    );
  }

  @override
  PaymentViewModel get init => PaymentViewModel();
}

class _PaymentLayout extends StatelessWidget {
  const _PaymentLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PaymentViewModel>(
      builder: (context, model, child) {
        return ListView(
          children: [
            const ImageViewer(
              'https://hoithanh.com/wp-content/uploads/2015/07/b7433357-de29-4381-9cd4-9c2b8882f4c0.jpg',
              // 'assets/images/pdf.png',
              hasViewImage: true,
            ),
            const SizedBox(height: 20),

            FormAlbum(onChanged: model.changeAlbum),
            const SizedBox(height: 20),

            PositionAniButtonComp(
              onPressed: model.requests,
              child: const Text(
                'View',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
