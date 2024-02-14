![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_get_max_value.sas

### Utilities

##### Utility macro to obtain the maximum value of a table column.

***

### Description
The program is used to obtain the max value of a column in a table for both numeric and character type columns. When all of the values for the given column are missing, the macro returns RESULT=0 for numeric or RESULT= for character type columns.

##### *Note:*
*The output argument RESULT should be set to: %local result; in the program that calls the m_utl_get_max_value.sas macro.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-11-23 00:00:00

### Version
* 23.1.11

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | table | Full LIBNAME.TABLENAME name of the lookup table. The default value for TABLE is: \_NONE\_. |
| Input | column | Contains the name from which the maximum value is to be obtained. The default value for COLUMN is: \_NONE\_. |
| Output | result | Contains the macro variable name in which the result output is to be loaded. The default value for RESULT is: _MAX_VALUE_. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Maximum value for given table column: _MAX_VALUE_

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_get_max_value(?)
```

##### Example 2: Get the maximum value for AGE from SASHELP.class:
```sas
%let _max_age=;

%m_utl_get_max_value(
   table  = SASHELP.class
 , column = Age
 , result = _max_age
 , debug  = Y
   );

%put The maximum age in SASHELP.class is: &_max_age.;
```

##### Example 3: Get the maximum value for NAME from SASHELP.class:
```sas
%let _max_name=;

%m_utl_get_max_value(
   table = SASHELP.class
 , column = Name
 , result = _max_name
 , debug  = Y
   );

%put The highest name in SASHELP.class is: &_max_name.;
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
*This document was generated on 2023.11.23 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
