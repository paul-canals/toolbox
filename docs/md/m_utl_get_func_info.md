![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_get_func_info.sas

### Utilities

##### Utility macro to collect the user compiled function information.

***

### Description
This program collects the user compiled functions information from a given filepath, function conatiner, or uses the CMPLIB system option to list function library container references.



### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-12-07 00:00:00

### Version
* 23.1.12

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | indir | Specifies the full path and name to a function subroutine container. If omitted, the macro uses the CMPLIB function compiler subroutines system option value. The default value is: \_NONE\_. |
| Input | prefix | Optional. Specifies a textual string to filter the output returned by the functions content. |
| Input | outlib | Specifies the LIBNAME name in which the output SAS datasets or database tables will be stored. The default value for OUTLIB is: \_NONE\_. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* WORK.mcat_info

### Calls
* [m_utl_nlobs.sas](m_utl_nlobs.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_quote_elems.sas](m_utl_quote_elems.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_get_func_info(?)
```

##### Example 2: Get the functions list from CMPLIB system option:
```sas
%m_utl_get_func_info(
   outlib = WORK
 , debug  = Y
   );
```

##### Example 3: Get the functions list using INDIR parameter:
```sas
%m_utl_get_func_info(
   indir  = %str(&APPL_MCAT./functs.sas7bdat)
 , prefix = F_
 , outlib = WORK
 , debug  = Y
   );

```

### Copyright
Copyright 2008-2023 Paul Alexander Canals y Trocha. 
 
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
*This document was generated on 2023.12.07 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
