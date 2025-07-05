<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Agenda extends Model
{
    use HasFactory;

    protected $table = "tbl_agenda";

    // Jika ingin lebih aman dan eksplisit, gunakan fillable
    protected $fillable = [
        'judul',
        'keterangan',
        'penulis',
    ];
}
