# File Reference: m_utl_get_pathname.sas

### Utilities

##### Utility macro to obtain the path of a SAS libref or fileref.

***

### Description
This macro searches for the directory path of a SAS libref or fileref by using the dictionary table information. In case of a SAS libref, the macro returns the full path of the library or alias. For concatenated SAS librefs, the macro returns all paths in a single quoted string when using the default value for REF_POS=_ALL_. When the optional REF_POS parameter is set, the macro returns the path representing the positional value. For a SAS fileref, the macro returns both path and file name. This macro runs inline per default, but can be used to return the result into a global SAS macro variable specified by the GLOBAL_FLG and MVAR_NAME parameters.

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-02-14 00:00:00

### Version
* 20.1.02

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | ref_name | Full name of the SAS libref or fileref. The default value for REF_NAME is: \_NONE\_. |
| Input | ref | Optional. Alias of the REF_NAME= parameter. |
| Input | ref_type | Parameter [F/L] to specify whether the REF_NAME value contains a SAS libref (L) or fileref (F). The default value for REF_TYPE is: L. |
| Input | type | Optional. Alias of the REF_TYPE= parameter. |
| Input | ref_pos | Optional. Parameter to specify the positional number to select a result path when using the macro program on a concatenated SAS library. The default value for REF_POS is: _ALL_. |
| Input | pos | Optional. Alias of the REF_POS= parameter. |
| Input | global_flg | Boolean [Y/N] Parameter to specify wether the result value is to be declared as a global macro variable. If set to N, the result is returned inline. The default value for GLOBAL is: N. |
| Output | mvar_name | Name of the global variable containing the path name result. The default value is: _pathname. |
| Input | show_err | Boolean [Y/N] parameter to show or hide warnings or errors in the log. The default value is: Y. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Returns a full directory path (and name for fileref).

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_get_pathname(?)
```

##### Example 2: obtain the full path for SAS libref SASUSER:
```sas
data WORK.result;
   attrib libref length=$8 label='Library';
   attrib path length=$4096 label='Path';
   libref = 'SASUSER';
   path = strip("%m_utl_get_pathname(ref=SASUSER,type=L,debug=N)");
run;

proc print data=WORK.result label noobs;
run;
```

##### Example 3: obtain all paths for concatenated SAS libref SASHELP:
```sas
data WORK.result;
   attrib libref length=$8 label='Library';
   attrib path length=$4096 label='Path';
   libref = 'SASHELP';
   path = strip("%m_utl_get_pathname(ref=SASHELP,type=L,debug=N)");
run;

proc print data=WORK.result label noobs;
run;
```

##### Example 4: obtain second path for concatenated SAS libref SASHELP:
```sas
data WORK.result;
   attrib libref length=$8 label='Library';
   attrib path length=$4096 label='Path';
   libref = 'SASHELP';
   path = strip("%m_utl_get_pathname(ref=SASHELP,type=L,pos=2,debug=N)");
run;

proc print data=WORK.result label noobs;
run;
```

### Copyright
Copyright 2008-2020 Paul Alexander Canals y Trocha. 
 
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
*This document was generated on 30.10.2022 at 09:13:05  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
