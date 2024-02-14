![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_set_usermods.sas

### Utilities

##### Utility macro to create a user specific autoexec.sas program.

***

### Description
This program creates an initial user specific an autoexec.sas program in a given directory defined by the _FILE=_ parameter. The file can be included by the appserver_autoexec_usermods.sas at user logon to the SAS system.

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-09-26 00:00:00

### Version
* 23.1.09

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | file | The name and full path of the user specific autoexec_usermods.sas file The default value is: USER_DBMS_LIST. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* None

### Calls
* [m_utl_get_userid.sas](m_utl_get_userid.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_set_usermods(?)
```

##### Example 2: Include personal autoexec_usermods entries:
```sas
%m_utl_set_usermods(
   file  = %str(%sysfunc(getoption(WORK))/autoexec_usermods.sas)
 , debug = N
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
*This document was generated on 2023.09.26 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
