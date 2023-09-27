![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_get_meta_info.sas

### Utilities

##### Utility macro to collect the user SAS metadata information.

***

### Description
This program collects user information by reading from the SAS Metadata Server. The result can be filtered by using prefixes and/or wildcard list of search words.

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-12-12 00:00:00

### Version
* 20.1.12

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | userid | Specifies the user name or user identifier. If the parameter value is omitted, the user id value will be determined automatically. The default value for USERID is: \_NONE\_. |
| Input | prefix | Optional. Specifies a textual string to filter the output from the SAS metadata identity group. |
| Input | contains | Optional. Specifies a character search string to reduce group membership roles selected in the result to those having the contain parameter word value as part of the group membership name. |
| Input | position | Optional. indicator [START/END] or left blank to determine where the parameter CONTAINS value is to be used to search the group membership name. |
| Input | outlib | Specifies the LIBNAME name in which the output SAS datasets or database tables will be stored. The default value for OUTLIB is: \_NONE\_. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* WORK.meta_info

### Calls
* [m_utl_get_userid.sas](m_utl_get_userid.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_get_meta_info(?)
```

##### Example 2: Get the current user information from SAS Metadata:
```sas
%m_utl_get_meta_info(
   outlib = WORK
 , debug  = Y
   );
```

##### Example 3: Get the SASDEMO information from SAS Metadata:
```sas
%m_utl_get_meta_info(
   userid = sasdemo
 , outlib = WORK
 , debug  = Y
   );
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
*This document was generated on 26.09.2023 at 15:41:11  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
