![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_utl_get_sys_info.sas

### Utilities

##### Utility macro to collect the SAS system environment information.

***

### Description
This program collects the SAS system environment information from the SAS server system as also the user own client system.

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-07-18 00:00:00

### Version
* 23.1.07

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | outlib | Specifies the LIBNAME name in which the output SAS datasets or database tables will be stored. The default value for OUTLIB is: \_NONE\_. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* WORK.sys_info

### Calls
* [m_utl_nlobs.sas](m_utl_nlobs.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_get_sys_info(?)
```

##### Example 2: Get the SAS system and environment information:
```sas
%m_utl_get_sys_info(
   outlib = WORK
 , debug  = Y
   );

proc print data=WORK.sys_info label noobs;
   id system / style(data)={fontweight=medium};
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
*This document was generated on 13.09.2023 at 19:03:34  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
