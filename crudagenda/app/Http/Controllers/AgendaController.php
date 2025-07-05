<?php

namespace App\Http\Controllers;

use App\Models\Agenda;
use Illuminate\Http\Request;

class AgendaController extends Controller
{
    public function index()
    {
        return Agenda::all();
    }

    public function store(Request $request)
    {
        return Agenda::create($request->all());
    }

    public function show($id)
    {
        return Agenda::findOrFail($id);
    }

    public function update(Request $request, $id)
    {
        $agenda = Agenda::findOrFail($id);
        $agenda->update($request->all());
        return $agenda;
    }

    public function destroy($id)
    {
        return Agenda::destroy($id);
    }
}
