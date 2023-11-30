import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataPicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const DataPicker({Key? key, required this.onDateSelected}) : super(key: key);

  @override
  _DataPickerState createState() => _DataPickerState();
}

class _DataPickerState extends State<DataPicker> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });

      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black54,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.transparent,
        ),
        child: Center(
          child: Text(
            'Data da Avaliação',
            style: GoogleFonts.lexendDeca(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
