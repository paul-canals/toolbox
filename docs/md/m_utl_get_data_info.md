[![../../misc/images/doc_header.png](../../misc/images/doc_header.png)](#)
# 
# File Reference: m_utl_get_data_info.sas

### Utilities

##### Utility macro to collect the user session library information.

***

### Description
This program collects the user session data library information from the SAS dictionary tables. The result list can be filtered using prefixes and/or wildcard list of search words.



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
| Input | prefix | Optional. Specifies a textual string to filter the output returned by the dictionary tables. |
| Input | contains | Optional. Specifies a character search string to reduce the selected data libraries in the result to those having the contain parameter word value as part of the data library name. |
| Input | position | Optional. Indicator [START/END] or left blank to determine where the parameter CONTAINS word value is positioned in the data library name. |
| Input | outlib | Specifies the LIBNAME name in which the output SAS datasets or database tables will be stored. The default value for OUTLIB is: \_NONE\_. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* WORK.data_info

### Calls
* [m_utl_get_sashelp.sas](m_utl_get_sashelp.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_quote_elems.sas](m_utl_quote_elems.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_get_data_info(?)
```

##### Example 2: Get the data library list containing all libnames:
```sas
%m_utl_get_data_info(
   outlib = WORK
 , debug  = Y
   );
```

##### Example 3: Get the data library list containing libnames with HELP:
```sas
%m_utl_get_data_info(
   contains = HELP
 , position = END
 , outlib   = WORK
 , debug    = Y
   );
```

##### Example 4: Get the data library list containing libnames with SAS or WORK:
```sas
%m_utl_get_data_info(
   contains = SAS Work
 , outlib   = WORK
 , debug    = Y
   );
```

##### Example 5: Get the data library list containing libnames with prefix SAS:
```sas
%m_utl_get_data_info(
   prefix = SAS
 , outlib = WORK
 , debug  = Y
   );
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
*This document was generated on 2021.10.21 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
