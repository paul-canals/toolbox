![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_mstore_copy.sas

### Utilities

##### Utility macro to copy the contents of a SAS macro catalog.

***

### Description
This program copies the contents of a SAS macro catalog into the default user session SAS macro catalog in WORK.



### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-03-20 00:00:00

### Version
* 24.1.03

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | indir | Specifies the full path to the SAS macro catalog. The default value is: \_NONE\_. |
| Input | outlib | Specifies the full LIBNAME name of the output SAS macro catalog. The default value is: WORK. |
| Input | print | Boolean [Y/N] parameter to generate the output by a proc print step. The default value is: Y. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* The contents of a SAS macro catalog in WORK.sasmacr.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_mstore_copy(?)
```

##### Example 2: Copies the contents of a SAS macro catalog to WORK:
```sas
%m_utl_mstore_copy(
   indir  = %str(%sysget(SASROOT)/core/sashelp)
 , outlib = WORK
 , print  = Y
 , debug  = Y
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
*This document was generated on 2024.03.20 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
