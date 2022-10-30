# File Reference: m_utl_get_sashelp.sas

### Utilities

##### Utility macro to select information from SAS dictionary tables.

***

### Description
The macro can be usefull to select and extract information from SAS dictionary tables. The dictionary tables are listed under the SASHELP SAS library reference:
 VALLOPT
 (Contains information about SAS system and graphics options) VCATALG
 (Contains information about known SAS catalogs) VCHKCON
 (Contains information about known check constraints) VCOLUMN
 (Contains information about columns in all known tables) VCNCOLU
 (Contains information about columns that are referred to by integrity constraints) VCNTABU
 (Contains information about tables that have integrity constraints defined on them) VDATAIT
 (Contains information about known information map data items) VDEST
 (Contains information about known ODS destinations) VDCTNRY
 (Contains information about all SAS dictionary tables) VENGINE
 (Contains information about SAS engines) VEXTFL
 (Contains information about known external files) VFILTER
 (Contains information about known information map filters) VFORMAT
 (Contains information about current accessible formats and informats) VFUNC
 (Contains information about current accessible functions) VGOPT
 (Contains information about current defined graphics options) VINDEX
 (Contains information about known indexes) VINFOMP
 (Contains information about known information maps) VLIBNAM
 (Contains information about current defined libraries) VMACRO
 (Contains information about current defined macro variables) VMEMBER
 (Contains information about all objects that are in current defined libraries) VSACCES
 (Contains information about allocated libraries and user created views list) VSCATLG
 (Contains information about allocated libraries and known SAS catalogs list) VSLIB
 (Contains information about allocated libraries and physical path name information) VSTABLE
 (Contains information about allocated libraries and known tables list) VSTABVW
 (Contains information about allocated libraries and known tables/views list) VSVIEW
 (Contains information about allocated libraries and known views list) VOPTION
 (Contains information about SAS system options) VREFCON
 (Contains information about referential constraints) VREMEMB
 (Contains information about known remembers) VSTYLE
 (Contains information about known ODS styles) VTABCON
 (Contains information about integrity constraints in all known tables) VTABLE
 (Contains information about known tables) VTITLE
 (Contains information about current defined titles and footnotes) VVIEW
 (Contains information about known data views) VXATTR
 (Contains information about extended attributes)

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2021-10-21 00:00:00

### Version
* 21.1.10

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | ddlib | Specifies the name of the SAS library reference. The default value for DDLIB is: SASHELP. |
| Input | lib | Optional. Alias of the DDLIB= parameter. |
| Input | ddtbl | Specifies the name of the SAS dictionary table. Optionally this parameter value may include a combination of data step style statements between brackets like where=, keep=, drop= or rename=(). The default value for DDBTBL is: \_NONE\_. |
| Input | table | Optional. Alias of the DDTBL= parameter. |
| Input | outtbl | Specifies the full LIBNAME.TABLENAME name of the output SAS dataset or database table. Optionally this parameter value may include a combination of data step style statements between brackets like where=, keep=, drop= or rename=(). The default value for OUTTBL is: WORK._sashelp. |
| Input | out | Optional. Alias of the OUTTBL= parameter. |
| Input | sort | Specifies the sort-by-group columns for sorting the OUTTBL table. The SORT column list must be separated with a blank character, and the use of the descending argument is allowed. The default value for SORT is: \_NONE\_. |
| Input | info | Boolean [Y/N] parameter to generate and return a summary containing detailed information on the selected dictionary table selected by the TABLE argument. The default value is: N. |
| Input | print | Boolean [Y/N] parameter to generate the output by using proc report steps with style HtmlBlue. The default value for PRINT is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Content information of the selected SAS dictionary table.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_get_sashelp(?)
```

##### Example 2: Print content information on all SAS dictionary tables:
```sas
%m_utl_get_sashelp(
   table = _ALL_
 , info  = Y
 , debug = N
   )
```

##### Example 3: Obtain information on all currently assigned libraries:
```sas
%m_utl_get_sashelp(
   table = VLIBNAM
 , info  = Y
 , debug = N
   )
```

##### Example 4: Obtain information on all temporary assigned libraries:
```sas
%m_utl_get_sashelp(
   table = VLIBNAM (where=(upcase(temp)='YES'))
 , print = Y
 , debug = N
   )
```

##### Example 5: Create output table with all temporary assigned libraries:
```sas
%m_utl_get_sashelp(
   table = VLIBNAM (where=(upcase(temp)='YES' and upcase(sysname)='FILENAME'))
 , out   = WORK.tmplibs
 , print = N
 , debug = N
   )

proc print data=WORK.tmplibs label;
run;
```

##### Example 6: Obtain information on all SASHELP paths, sorted by libname and level:
```sas
%m_utl_get_sashelp(
   table = VLIBNAM (where=(upcase(libname)='SASHELP' and upcase(sysname)='FILENAME'))
 , out   = WORK.sashelp (keep=libname engine path level readonly temp)
 , sort  = libname descending level
 , print = Y
 , debug = N
   )

proc contents data=WORK.sashelp;
run;
```

##### Example 7: Obtain information on concatenated libraries, sorted by libname and path:
```sas
%m_utl_get_sashelp(
   table = VLIBNAM (where=(upcase(sysname) = 'FILENAME' and level > 0))
 , out   = WORK.libraries (keep=libname engine path level readonly temp)
 , sort  = libname path
 , print = N
 , debug = N
   )

data WORK.libraries (drop=level);
   set WORK.libraries;
   attrib concat length=$3 label='Concatenated?';
   if level gt 0 then concat='yes';
   else concat='no';
run;

proc print data=WORK.libraries label;
run;
```

### Copyright
Copyright 2008-2021 Paul Alexander Canals y Trocha. 
 
This program is free software: you can redistribute it and/or modify 
it under the terms of the GNU General Public License as published by 
the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version. 
 
This program is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the 
GNU General Public License for more details. 
 
You should have received a copy of the GNU General Public License 
along with this program. If not, see <https://www.gnu.org/licenses/>. 


***
*This document was generated on 30.10.2022 at 09:13:06  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
