import 'package:flutter/material.dart';
import 'agenda.dart';
import 'agenda_service.dart';

class AgendaForm extends StatefulWidget {
  final Agenda? agenda;
  const AgendaForm({super.key, this.agenda});

  @override
  State<AgendaForm> createState() => _AgendaFormState();
}

class _AgendaFormState extends State<AgendaForm> {
  final _formKey = GlobalKey<FormState>();
  final _judul = TextEditingController();
  final _ket = TextEditingController();
  final _penulis = TextEditingController(); // Controller penulis
  final _service = AgendaService();

  @override
  void initState() {
    super.initState();
    if (widget.agenda != null) {
      _judul.text = widget.agenda!.judul;
      _ket.text = widget.agenda!.keterangan;
      _penulis.text =
          widget.agenda!.penulis; // ✅ Tanpa ?? '' karena non-nullable
    }
  }

  @override
  void dispose() {
    _judul.dispose();
    _ket.dispose();
    _penulis.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final agenda = Agenda(
        id: widget.agenda?.id,
        judul: _judul.text,
        keterangan: _ket.text,
        penulis: _penulis.text,
      );

      try {
        if (widget.agenda == null) {
          await _service.create(agenda);
        } else {
          await _service.update(agenda.id!, agenda);
        }

        if (!mounted) return;
        Navigator.pop(context, true);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal simpan: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.agenda == null ? 'Tambah Agenda' : 'Edit Agenda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _judul,
                decoration: const InputDecoration(labelText: 'Judul'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Wajib isi judul' : null,
              ),
              TextFormField(
                controller: _ket,
                decoration: const InputDecoration(labelText: 'Keterangan'),
              ),
              TextFormField(
                controller: _penulis,
                decoration: const InputDecoration(labelText: 'Penulis'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Wajib isi penulis' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _submit, child: const Text('Simpan')),
            ],
          ),
        ),
      ),
    );
  }
}
