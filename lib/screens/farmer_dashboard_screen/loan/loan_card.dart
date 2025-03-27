import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpendingCards extends StatefulWidget {
  const SpendingCards({Key? key}) : super(key: key);

  @override
  _SpendingCardsState createState() => _SpendingCardsState();
}

class _SpendingCardsState extends State<SpendingCards> {
  // List to store editable spending items
  final List<SpendingCardItem> _spendingItems = [
    const SpendingCardItem(
      color: Color(0xFF4318D1),
      name: 'Mr Tan',
      amount: 4500,
    ),
    const SpendingCardItem(
      color: Color(0xFFFFB800),
      name: 'Public Bank',
      amount: 3200,
    ),
    const SpendingCardItem(
      color: Color(0xFF00B37E),
      name: 'Maybank',
      amount: 2800,
    ),
    const SpendingCardItem(
      color: Color(0xFFFF6B6B),
      name: 'Mr Chua',
      amount: 2000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _spendingItems.map((item) {
        return Column(
          children: [
            _EditableSpendingCardItem(
              item: item,
              onUpdate: (newName, newAmount) {
                setState(() {
                  // Create a new item with updated values
                  final index = _spendingItems.indexOf(item);
                  _spendingItems[index] = SpendingCardItem(
                    color: item.color,
                    name: newName,
                    amount: newAmount,
                  );
                });
              },
            ),
            const SizedBox(height: 24),
          ],
        );
      }).toList(),
    );
  }
}

class SpendingCardItem extends StatelessWidget {
  final Color color;
  final String name;
  final int amount;

  const SpendingCardItem({
    required this.color,
    required this.name,
    required this.amount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width > 991 ? 24 : 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A612D),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                name,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: const Color(0xFFFFFFF6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'RM',
                style: GoogleFonts.inter(
                  fontSize: MediaQuery.of(context).size.width > 640 ? 24 : 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFFFFF6),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                amount.toString(),
                style: GoogleFonts.inter(
                  fontSize: MediaQuery.of(context).size.width > 640 ? 24 : 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFFFFF6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'this month',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFFFFFFF6),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditableSpendingCardItem extends StatefulWidget {
  final SpendingCardItem item;
  final Function(String, int) onUpdate;

  const _EditableSpendingCardItem({
    Key? key,
    required this.item,
    required this.onUpdate,
  }) : super(key: key);

  @override
  __EditableSpendingCardItemState createState() => __EditableSpendingCardItemState();
}

class __EditableSpendingCardItemState extends State<_EditableSpendingCardItem> {
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
    _amountController = TextEditingController(text: widget.item.amount.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      if (_isEditing) {
        // Save changes
        widget.onUpdate(
          _nameController.text,
          int.tryParse(_amountController.text) ?? widget.item.amount,
        );
      }
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width > 991 ? 24 : 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A612D),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: widget.item.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  _isEditing
                      ? SizedBox(
                          width: 100,
                          child: TextField(
                            controller: _nameController,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color(0xFFFFFFF6),
                            ),
                            decoration: const InputDecoration(
                              isDense: true,
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : Text(
                          widget.item.name,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: const Color(0xFFFFFFF6),
                          ),
                        ),
                ],
              ),
              IconButton(
                icon: Icon(
                  _isEditing ? Icons.save : Icons.edit,
                  color: Colors.white,
                  size: 20,
                ),
                onPressed: _toggleEdit,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'RM',
                style: GoogleFonts.inter(
                  fontSize: MediaQuery.of(context).size.width > 640 ? 24 : 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFFFFFF6),
                ),
              ),
              const SizedBox(width: 4),
              _isEditing
                  ? SizedBox(
                      width: 80,
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.inter(
                          fontSize: MediaQuery.of(context).size.width > 640 ? 24 : 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFFFFFF6),
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  : Text(
                      widget.item.amount.toString(),
                      style: GoogleFonts.inter(
                        fontSize: MediaQuery.of(context).size.width > 640 ? 24 : 20,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFFFFFF6),
                      ),
                    ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'this month',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: const Color(0xFFFFFFF6),
            ),
          ),
        ],
      ),
    );
  }
}