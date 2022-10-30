# File Reference: m_utl_set_sasautos.sas

### Utilities

##### Utility macro to add a SAS macro path to the SASAUTOS list.

***

### Description
The macro will add a new SAS macro path in front of the existing SASAUTOS paths list.

##### *Note:*
*Be aware of the fact that SAS registers the SAS macro paths within the SASAUTO list in a sequential manner. This means that a macro is registered more than once, and it is the most actual registration of that macro which is in effect.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-09-07 00:00:00

### Version
* 20.1.09

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | path | Full qualified to the SAS macro path. The default value is: \_NONE\_. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* New SAS Autocall path added to the SASAUTOS list

### Calls
* [m_utl_create_dir.sas](m_utl_create_dir.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_set_sasautos(?)
```

##### Example 2: Extend the SASAUTO path list with WORK directory:
```sas
%m_utl_set_sasautos(
   path  = %sysfunc(getoption(WORK))
 , debug = Y
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
*This document was generated on 30.10.2022 at 09:13:36  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
