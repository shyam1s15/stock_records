import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stock_records/controllers/stock_controller.dart';
import 'package:stock_records/models/stock_record.dart';
import 'package:stock_records/utils/utility.dart';

class StockRecordTile extends StatefulWidget {
  StockRecord stockRecord;

  StockRecordTile({required this.stockRecord});

  @override
  State<StockRecordTile> createState() => _StockRecordTileState();
}

class _StockRecordTileState extends State<StockRecordTile> {
  final StockController stockController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white; // Default co
    if (widget.stockRecord.changePer != null) {
      if (widget.stockRecord.changePer! > 5) {
        backgroundColor = Colors.lightGreen;
      } else if (widget.stockRecord.changePer! < -5) {
        backgroundColor = Colors.redAccent;
      }
    }

    if (isPriceWithinTolerance(
        widget.stockRecord.currentPrice, widget.stockRecord.targetPrice)) {
      backgroundColor = Colors.orange;
    }

    return GestureDetector(
      onTap: () {
        Clipboard.setData(
            ClipboardData(text: widget.stockRecord.stockSymbol ?? 'N/A'));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  '${widget.stockRecord.stockSymbol} copied to clipboard')),
        );
        /*showModalBottomSheet(
          context: context,
          builder: (context) {
            return _buildBottomSheet(context);
          },
        );*/
      },
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
        ),
        child: Column(
          children: [
            ListTile(
              leading:
                  Icon(Icons.trending_up), // You can use an appropriate icon
              title: Text(widget.stockRecord.stockName ?? 'Unknown Stock'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Symbol: ${widget.stockRecord.stockSymbol ?? 'N/A'}'),
                  Text(
                      'Current Price: ₹${widget.stockRecord.currentPrice?.toStringAsFixed(2) ?? 'N/A'}'),
                  Text(
                      'Previous Price: ₹${widget.stockRecord.previousPrice?.toStringAsFixed(2) ?? 'N/A'}'),
                  Text(
                      'Change: ${widget.stockRecord.changePer?.toStringAsFixed(2) ?? 'N/A'}%'),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Updated: ${widget.stockRecord.lastUpdated != null ? _formatDate(widget.stockRecord.lastUpdated!) : 'N/A'}',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              isThreeLine: true,
            ),
            _buildHiddenTile()
          ],
        ),
      ),
    );
  }

  Widget _buildHiddenTile() {
    TextEditingController nearTargetPriceController = TextEditingController(
        text: widget.stockRecord.targetPrice?.toString() ?? '');
    TextEditingController noteController =
        TextEditingController(text: widget.stockRecord.note?.toString() ?? '');

    return ExpansionTile(
      title: Text(widget.stockRecord.targetPrice != null
          ? 'Target Price : ${widget.stockRecord.targetPrice}'
          : 'Set Target Price'),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Near Target Price'),
                controller: nearTargetPriceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a near target price.';
                  }

                  // Attempt to convert the value to a double
                  try {
                    double.parse(value);
                    return null; // Value is valid (a double)
                  } on FormatException {
                    return 'Invalid input: Please enter a number.';
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Note'),
                controller: noteController,
              ),
              SizedBox(height: 2),
              ElevatedButton(
                onPressed: () {
                  // Save logic here
                  double? target_price =
                      double.tryParse(nearTargetPriceController.text);
                  String? note = noteController.text;
                  stockController.saveTargetPriceAndNote(
                      widget.stockRecord.id?.oid, target_price, note);

                  setState(() {
                    widget.stockRecord.targetPrice = target_price;
                    widget.stockRecord.note = note;
                  });
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.stockRecord.stockName ?? 'Unknown Stock',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Symbol: ${widget.stockRecord.stockSymbol ?? 'N/A'}'),
          Text(
              'Current Price: ₹${widget.stockRecord.currentPrice?.toStringAsFixed(2) ?? 'N/A'}'),
          Text(
              'Previous Price: ₹${widget.stockRecord.previousPrice?.toStringAsFixed(2) ?? 'N/A'}'),
          Text(
              'Change: ${widget.stockRecord.changePer?.toStringAsFixed(2) ?? 'N/A'}%'),
          Text(
            'Last Updated: ${widget.stockRecord.lastUpdated != null ? _formatDate(widget.stockRecord.lastUpdated!) : 'N/A'}',
          ),
        ],
      ),
    );
  }
}
