![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_ds2cards.sas

### Utilities

##### Utility macro to export a SAS dataset into a SAS cards program.

***

### Description
This program converts a SAS dataset into a cards program file. The datalines cards program is a method to create SAS datasets independently from host or system to another.

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2022-11-08 00:00:00

### Version
* 22.1.11

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | base_ds | Full LIBNAME.TABLENAME name of the SAS dataset. The default value for BASE_DS is: _NONE. |
| Input | out_lib | Optional. Specifies an alternate output library location, used in the SAS data cards step file. The default value for OUT_LIB is: _NONE. |
| Input | cards_file | Specifies the full path and name of the CARDS file where the formatted output is written to. If the file that you specify does not exist, then it is created for you. The default value for CARDS_FILE is: \_NONE\_. |
| Input | print | Boolean [Y/N] parameter to generate the output by using proc report steps with style HtmlBlue. The default value for PRINT is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Output cards file.

### Calls
* [m_utl_create_dir.sas](m_utl_create_dir.md)
* [m_utl_get_sashelp.sas](m_utl_get_sashelp.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_ds2cards(?)
```

##### Example 2: Create cards statement for table SASHELP.class:
```sas
%m_utl_ds2cards(
   base_ds    = SASHELP.class
 , cards_file = %str(%sysfunc(getoption(WORK))/class.sas)
 , print      = Y
 , debug      = Y
   );
```

##### Example 3: Create cards statement for table WORK.class:
```sas
%m_utl_ds2cards(
   base_ds    = SASHELP.class
 , out_lib    = WORK
 , cards_file = %str(%sysfunc(getoption(WORK))/class.sas)
 , print      = Y
 , debug      = Y
   );
```

### Copyright
Copyright 2008-2022 Paul Alexander Canals y Trocha. 
 
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
*This document was generated on 26.09.2023 at 15:40:36  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
