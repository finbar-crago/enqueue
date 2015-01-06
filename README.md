Enqueue PBX [![Build Status](https://travis-ci.org/finbar-crago/enqueue.svg?branch=master)](https://travis-ci.org/finbar-crago/enqueue)
=======

## NAME

EnQ - The Enqueue PBX Libraries

## SYNOPSIS

    use EnQ;

    my $Q = EnQ->new({config => 'my_config.yml'});

    my $U = $Q->Obj('User');
    $U->pull('user_id');
    print $U->name;

## AUTHOR

Finbar Crago <finbar.crago@gmail.com>

## COPYRIGHT AND LICENSE

Copyright (C) 2014-2015 Finbar Crago

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see [http://www.gnu.org/licenses/](http://www.gnu.org/licenses/).
