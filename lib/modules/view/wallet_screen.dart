import 'package:barcode/barcode.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:car_marketplace_app/config/theme/theme_style.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:svg_flutter/svg.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: const _BuildBody(),
    );
  }

  /// --- AppBar Block ---
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'My E-Wallet',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      centerTitle: false,
      leading: const Icon(
        Icons.car_crash_sharp,
        color: Colors.black,
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 18.0),
          child: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18, top: 20),
        child: Column(
          children: [
            _buildCreditCard(context),
            _buildTransactionHistory(context)
          ],
        ),
      ),
    );
  }

  _buildTransactionHistory(BuildContext context) {
    final List<Map<String, dynamic>> transactions = [
      {
        'title': 'BMW M4',
        'date': 'Oct 01, 2025 | 10:10am',
        'amount': '\$72,000',
        'type': 'Orders',
        'iconUrl':
            'https://t4.ftcdn.net/jpg/04/20/38/41/360_F_420384111_5fzxWlWxvB7bg5BROxfKdBbgBYB2TwGP.jpg',
      },
      {
        'title': 'Audi R8',
        'date': 'Sep 28, 2025 | 02:30pm',
        'amount': '\$140,000',
        'type': 'Orders',
        'iconUrl':
            'https://t4.ftcdn.net/jpg/04/20/38/41/360_F_420384111_5fzxWlWxvB7bg5BROxfKdBbgBYB2TwGP.jpg',
      },
      {
        'title': 'Wallet Top-up',
        'date': 'Sep 25, 2025 | 12:00pm',
        'amount': '\$5,000',
        'type': 'Top-up',
        'iconUrl':
            'https://t4.ftcdn.net/jpg/04/20/38/41/360_F_420384111_5fzxWlWxvB7bg5BROxfKdBbgBYB2TwGP.jpg',
      },
      {
        'title': 'Wallet Top-up',
        'date': 'Sep 20, 2025 | 09:15am',
        'amount': '\$2,500',
        'type': 'Top-up',
        'iconUrl':
            'https://t4.ftcdn.net/jpg/04/20/38/41/360_F_420384111_5fzxWlWxvB7bg5BROxfKdBbgBYB2TwGP.jpg',
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaction History',
                style: AppTextStyle.bold16(color: Colors.black),
              ),
              Text(
                'see all',
                style: AppTextStyle.regular12(color: Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            children: List.generate(transactions.length, (index) {
              final tx = transactions[index];
              final isOrder = tx['type'] == 'Orders';

              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BarCode()),
                  );
                },
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                leading: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: tx['iconUrl'],
                      fit: BoxFit.cover,
                      width: 32,
                      height: 32,
                    ),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx['title'],
                      style: AppTextStyle.bold16(color: Colors.black),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tx['date'],
                      style: AppTextStyle.regular12(color: Colors.black54),
                    ),
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tx['amount'],
                      style: AppTextStyle.bold16(
                          color: isOrder ? Colors.red : Colors.green),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          tx['type'],
                          style: AppTextStyle.regular12(color: Colors.black54),
                        ),
                        const SizedBox(width: 2),
                        Icon(
                          isOrder
                              ? Icons.arrow_downward_outlined
                              : Icons.arrow_upward_outlined,
                          color: isOrder ? Colors.red[400] : Colors.green[400],
                          size: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditCard(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
        depth: 8,
        lightSource: LightSource.topLeft,
        color: Colors.black,
      ),
      child: CreditCardWidget(
        cardNumber: '4111 1111 1111 1111',
        expiryDate: '12/25',
        cardHolderName: 'John Doe',
        cvvCode: '123',
        bankName: 'VISA',
        obscureCardCvv: false,
        showBackView: false,
        onCreditCardWidgetChange: (CreditCardBrand brand) {},
        cardBgColor: Colors.blue,
        glassmorphismConfig: Glassmorphism.defaultConfig(),
        // backgroundImage: 'assets/images/card_bg.png',
        // backgroundNetworkImage: 'https://mockvisa.com/images/cta-bg.png',
        labelValidThru: 'VALID THRU',
        labelCardHolder: 'CARD HOLDER',
        cardType: CardType.mastercard,
        isHolderNameVisible: true,
        height: 200,
        width: MediaQuery.of(context).size.width,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        frontCardBorder: Border.all(color: Colors.grey),
        backCardBorder: Border.all(color: Colors.grey),
        chipColor: Colors.amber[400],
        padding: 16,
      ),
    );
  }
}

class BarCode extends StatefulWidget {
  const BarCode({super.key});

  @override
  State<BarCode> createState() => _BarCodeState();
}

class _BarCodeState extends State<BarCode> {
  @override
  Widget build(BuildContext context) {
    final bc = Barcode.code39();
    final svgString = bc.toSvg(
      'CODE 39 DATA',
      width: 300,
      height: 80,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.string(
            svgString,
            width: 300,
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.black.withValues(alpha: 0.05),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    // Car Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://img.freepik.com/free-psd/black-isolated-car_23-2151852894.jpg?semt=ais_hybrid&w=740&q=80',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Car Details
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('BMW M4',
                              style: AppTextStyle.bold20(color: Colors.black)),
                          const SizedBox(height: 6),
                          Row(
                            spacing: 10,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                              ),
                              Text('BLACK',
                                  style: AppTextStyle.regular14(
                                      color: Colors.black)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildAmount,
          _buildPayment
        ],
      ),
    );
  }

  Widget get _buildAmount {
    final List<Map<String, String>> amountList = [
      {'title': 'Amount', 'value': '\$17,000'},
      {'title': 'Shipping', 'value': '\$250'},
      {'title': 'Tax', 'value': '\$1,000'},
      {'title': 'Total Amount', 'value': '\$18,250'},
    ];

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: List.generate(amountList.length, (index) {
              final item = amountList[index];

              // Add a Divider before Total Amount
              bool isLast = index == amountList.length - 1;
              bool isDivider = index == amountList.length - 2; // before total

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['title']!,
                          style: AppTextStyle.regular14(color: Colors.black)),
                      Text(item['value']!,
                          style: AppTextStyle.bold16(color: Colors.black)),
                    ],
                  ),
                  if (!isLast) const SizedBox(height: 10),
                  if (isDivider) const Divider(color: Colors.black12),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget get _buildPayment {
    final List<Map<String, String>> amountList = [
      {'title': 'Payment Methods', 'value': 'E-Wallet'},
      {'title': 'Date', 'value': 'Jul 12, 2025, 10:10:27 AM'},
      {'title': 'Tracsaction ID', 'value': 'SK4875745429'},
      {'title': 'Status', 'value': 'Paid'},
    ];

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: List.generate(amountList.length, (index) {
              final item = amountList[index];

              bool isLast = index == amountList.length - 1;
              bool isDivider = index == amountList.length - 2;

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['title']!,
                          style: AppTextStyle.regular14(color: Colors.black)),
                      Text(item['value']!,
                          style: AppTextStyle.bold16(color: Colors.black)),
                    ],
                  ),
                  if (!isLast) const SizedBox(height: 10),
                  if (isDivider) const Divider(color: Colors.black12),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  /// --- AppBar Block ---
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'E-Receipt',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      centerTitle: false,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: Colors.black,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 18.0),
          child: Icon(
            Icons.more_horiz_rounded,
            color: Colors.black,
          ),
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}
