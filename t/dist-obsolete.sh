#! /bin/sh
# Copyright (C) 2003-2012 Free Software Foundation, Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Obsolete archive formats.

. ./defs || exit 1

$ACLOCAL

for fmt in lzma shar; do
  echo AUTOMAKE_OPTIONS = dist-$fmt > Makefile.am
  AUTOMAKE_fails -Wnone -Wno-error
  grep "^Makefile\\.am:1:.*support for $fmt.*removed" stderr
done

rm -rf autom4te*.cache

cat > configure.ac << 'END'
AC_INIT([lzma], [1.0])
AM_INIT_AUTOMAKE([dist-tarZ])
AC_CONFIG_FILES([Makefile])
END
: > Makefile.am
$ACLOCAL
AUTOMAKE_fails -Wnone -Wno-error
grep "^configure\\.ac:2:.*legacy 'compress' program.* no more supported" stderr

: