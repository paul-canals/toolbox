[![../../misc/images/doc_header.png](../../misc/images/doc_header.png)](#)
# 
# File Reference: m_utl_get_dspath.sas

### Utilities

##### Utility macro to get full path and file name of a SAS dataset.

***

### Description
The macro uses the funcionality of the SAS proc contents procedure to obtain the full path including file name for an input SAS dataset. The result path and file name string is loaded and returned into a SAS macro variable.



### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-10-28 00:00:00

### Version
* 24.1.10

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | table | Full LIBNAME.TABLENAME name of the or SAS dataset. The default value is: _NONE. |
| Input | dataset | Alias of the TABLE= parameter. |
| Input | global | Boolean [Y/N] Parameter to declare if the result SAS macro variable is to be declared globally. The Default value is: N. |
| Output | varname | Name of the global SAS macro variable containing the full path and file name of the given dataset. The default value is: _dspath. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* A SAS macro variable containing the full path and file name of a SAS dataset.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_get_dspath(?)
```

##### Example 2: Get the full path of the SASHELP.class dataset:
```sas
%m_utl_get_dspath(
   dataset = SASHELP.class
 , global  = Y
 , varname = dspath
 , debug   = Y
   );
%put &=dspath.;
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
*This document was generated on 2024.10.28 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
