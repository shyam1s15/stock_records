import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stock_records/models/stock_record.dart';

class StockRecordTile extends StatelessWidget {
  final StockRecord stockRecord;

  StockRecordTile({required this.stockRecord});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white; // Default color

    if (stockRecord.changePer != null) {
      if (stockRecord.changePer! > 5) {
        backgroundColor = Colors.lightGreen;
      } else if (stockRecord.changePer! < -5) {
        backgroundColor = Colors.redAccent;
      }
    }
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: stockRecord.stockSymbol ?? 'N/A'));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${stockRecord.stockSymbol} copied to clipboard')),
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
        child: ListTile(
          leading: Icon(Icons.trending_up), // You can use an appropriate icon
          title: Text(stockRecord.stockName ?? 'Unknown Stock'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Symbol: ${stockRecord.stockSymbol ?? 'N/A'}'),
              Text('Current Price: ₹${stockRecord.currentPrice?.toStringAsFixed(2) ?? 'N/A'}'),
              Text('Previous Price: ₹${stockRecord.previousPrice?.toStringAsFixed(2) ?? 'N/A'}'),
              Text('Change: ${stockRecord.changePer?.toStringAsFixed(2) ?? 'N/A'}%'),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Updated: ${stockRecord.lastUpdated != null ? _formatDate(stockRecord.lastUpdated!) : 'N/A'}',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          isThreeLine: true,
        ),
      ),
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
            stockRecord.stockName ?? 'Unknown Stock',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Symbol: ${stockRecord.stockSymbol ?? 'N/A'}'),
          Text('Current Price: ₹${stockRecord.currentPrice?.toStringAsFixed(2) ?? 'N/A'}'),
          Text('Previous Price: ₹${stockRecord.previousPrice?.toStringAsFixed(2) ?? 'N/A'}'),
          Text('Change: ${stockRecord.changePer?.toStringAsFixed(2) ?? 'N/A'}%'),
          Text(
            'Last Updated: ${stockRecord.lastUpdated != null ? _formatDate(stockRecord.lastUpdated!) : 'N/A'}',
          ),
        ],
      ),
    );
  }
}
