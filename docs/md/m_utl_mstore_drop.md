![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_utl_mstore_drop.sas

### Utilities

##### Utility macro to delete a member from a SAS macro catalog.

***

### Description
This program deletes one or more members from a SAS macro catalog. The type of the catalog member is restricted by this program to the MACRO type entry.



### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-05-14 00:00:00

### Version
* 24.1.05

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | indir | Specifies the full path to the SAS macro catalog. The default value is: \_NONE\_. |
| Input | entry | Specifies a list of macro catalog members to be deleted from the catalog. The members are to be separated by a blank character. The default value is: \_NONE\_. |
| Input | print | Boolean [Y/N] parameter to generate the output by a proc print step. The default value is: Y. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* The contents of a SAS macro catalog.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_mstore_drop(?)
```

##### Example 2: Step 1 - Copy the contents of SASHELP core macro catalog:
```sas
options dlcreatedir;
libname TEMP "%sysfunc(getoption(WORK))/catalog";
options nodlcreatedir;

proc catalog cat=WORK.sasmac1 force;
   copy out=TEMP.sasmacr;
   run;
   contents;
   run;
quit;

libname TEMP clear;
```

##### Example 2: Step 2 - Delete a member from the copied macro catalog:
```sas
%m_utl_mstore_drop(
   indir = %sysfunc(getoption(WORK))/catalog
 , entry = M_UTL_MSTORE_DROP
 , print = Y
 , debug = Y
   );
```

### Copyright
Copyright 2008-2024 Paul Alexander Canals y Trocha. 
 
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
*This document was generated on 2024.05.14 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
