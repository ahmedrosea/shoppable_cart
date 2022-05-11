import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppablecard/components/default_button.dart';
import 'package:shoppablecard/components/product_drop_down_button.dart';
import 'package:shoppablecard/images.dart';
import 'package:shoppablecard/models/product_model.dart';
import 'package:shoppablecard/state_management/provider.dart';

import '../default_colors.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.productData}) : super(key: key);
  final ProductModel productData;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isInCart = context.watch<MyProvider>().isAdded;
    int? count = context.read<MyProvider>().count;
    bool isFavourite = context.watch<MyProvider>().isFavourite;

    return WillPopScope(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        '${ImagesUrls.products}${widget.productData.productImage}',
                    placeholder: (context, url) => const Center(
                      child: SizedBox(
                        height: 30.0,
                        width: 30.0,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        Center(child: Text('$error')),
                    height: (MediaQuery.of(context).size.height * 0.25),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: (MediaQuery.of(context).size.height),
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20.0, bottom: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productData.productName,
                          style: const TextStyle(
                            fontSize: 26.0,
                            fontFamily: 'SFPro',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ProductDropDownButton(
                                dropDownList: const [
                                  'S',
                                  'M',
                                  'L',
                                  'XL',
                                  'XXL',
                                  'XXXL'
                                ],
                                selectedValue: 'M',
                                dropDownButtonTitle: 'Size',
                                dropDownColors: const {},
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: ProductDropDownButton(
                                dropDownList: const ['red', 'green', 'blue'],
                                selectedValue: 'blue',
                                dropDownButtonTitle: 'Colour',
                                dropDownColors: const {
                                  'blue': Colors.blue,
                                  'red': Colors.red,
                                  'green': Colors.green
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        const Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: 'SFPro',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          widget.productData.productDescription,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'SFPro',
                            height: 1.6,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: BottomSheet(
                enableDrag: false,
                backgroundColor: Colors.white,
                constraints: BoxConstraints(
                    maxHeight: (MediaQuery.of(context).size.height * 0.11),
                    maxWidth: double.infinity),
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Price',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'SFPro',
                                color: Color(0xff929292),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              '\$${widget.productData.productPrice}',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'SFPro',
                                fontWeight: FontWeight.w700,
                                color: DefaultColors.defaultBlueColor,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 50.0,
                        ),
                        SizedBox(
                          child: isInCart
                              ? Container(
                                  width: 100.0,
                                  height: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () async {
                                            setState(() {
                                              context
                                                  .read<MyProvider>()
                                                  .incrementCartCount(
                                                      product:
                                                          widget.productData);
                                              context
                                                  .read<MyProvider>()
                                                  .incrementCount();
                                            });
                                          },
                                          child: SizedBox(
                                              height: double.infinity,
                                              child: Image.asset(
                                                  'assets/images/plus.png')),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          count.toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 24.0,
                                            fontFamily: 'SFPro',
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () async {
                                            setState(() {
                                              context
                                                  .read<MyProvider>()
                                                  .decrementCartCount(
                                                      product:
                                                          widget.productData);
                                              context
                                                  .read<MyProvider>()
                                                  .decrementCount();
                                            });
                                          },
                                          child: SizedBox(
                                              height: double.infinity,
                                              child: Image.asset(
                                                  'assets/images/minus.png')),
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                    color: Color.fromRGBO(0, 0, 0, 0.06),
                                  ),
                                )
                              : DefaultButton(
                                  text: 'add'.toUpperCase(),
                                  onPressed: () async {
                                    await context
                                        .read<MyProvider>()
                                        .insertProduct(
                                            productData: widget.productData);
                                    setState(() {
                                      context.read<MyProvider>().checkAdded(
                                          productData: widget.productData);
                                      isInCart =
                                          context.read<MyProvider>().isAdded;
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                          width: (MediaQuery.of(context).size.width * 0.4),
                        ),
                      ],
                    ),
                  );
                },
                onClosing: () {},
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.09,
                left: MediaQuery.of(context).size.width * 0.01,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 22.0,
                  ),
                )),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.095,
                right: MediaQuery.of(context).size.width * 0.04,
                child: InkWell(
                  onTap: () {
                    isFavourite
                        ? context.read<MyProvider>().deleteFromFavourite(
                            productData: widget.productData)
                        : context
                            .read<MyProvider>()
                            .addToFavourite(productData: widget.productData);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: isFavourite
                        ? const Icon(
                            Icons.star,
                          )
                        : const Icon(
                            Icons.star_border_outlined,
                          ),
                  ),
                )),
          ],
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}

/*
DropdownButton<String>(
                          underline: null,
                          value: _sizeValue,
                          icon: null,
                          items: _sizes.map((String value) {
                              return DropdownMenuItem<String>(
                                      value: value,
                                    child: Text(value),
                                        );
                                    }).toList(),
                                     onChanged: (String? newValue) {
                                        setState(() {
                                          _sizeValue= newValue!;
                                        });
                                     },
                                            ),
                        DropdownButton<String>(
                                items: <String>['A', 'B', 'C', 'D'].map((String value) {
                                  return DropdownMenuItem<String>(
                                        value: value,
                                      child: Text(value),
                                          );
                                          }).toList(),
                                  onChanged: (_) {},
)

 */