[![../../misc/images/doc_header.png](../../misc/images/doc_header.png)](#)
# 
# File Reference: m_utl_chk_table_exist.sas

### Utilities

##### Utility macro to check if a table exists and can be opened.

***

### Description
The program checks if a table or dataset exists and can be opened for reading and/or writing. The result is returned inline. The valid RESULT values are:

- RESULT \=  1 : Table exists and can be opened.
- RESULT \=  0 : Table does not exist.
- RESULT \= \-1 : Table exists, but can not be opened.



##### *Note:*
*The SHOW_ERR parameter shows or suppresses possible warnings or errors in the SAS log output destination.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-08-03 00:00:00

### Version
* 24.1.08

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | intable | Full LIBNAME.TABLENAME name of the source table or SAS dataset. The default value is: \_NONE\_. |
| Input | show_err | Boolean [Y/N] parameter to show or hide warnings or errors in the log. The default value is: Y. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Result inline macro value.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_chk_table_exist(?)
```

##### Example 2: Table exists and can be opened (RESULT=1):
```sas
%let tableExist =
   %m_utl_chk_table_exist(
      intable  = SASHELP.class
    , show_err = Y
    , debug    = Y
      );

%put &=tableExist.;

```

##### Example 3: Table does not exist (RESULT=0):
```sas
%let tableExist =
   %m_utl_chk_table_exist(
      intable  = WORK.class
    , show_err = Y
    , debug    = Y
      );

%put &=tableExist.;

```

##### Example 4: Table exists, but can not be opened (RESULT=-1):
```sas
lock SASHELP.class;

%let tableExist =
   %m_utl_chk_table_exist(
      intable  = SASHELP.class
    , show_err = Y
    , debug    = Y
      );

%put &=tableExist.;

lock SASHELP.class clear;

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
*This document was generated on 2024.08.03 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
