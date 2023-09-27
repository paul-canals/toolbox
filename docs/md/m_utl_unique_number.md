![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_unique_number.sas

### Utilities

##### Utility macro to generate a unique integer number value.

***

### Description
The macro generates a unique (integer) number based on a combination of a minimum \/ maximum value and a number sequence. The last number used value is held by a global SAS macro variable defined by the MVAR_NAME parameter.

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
| Input | min | Optional. Parameter to set the minimum value for the unique number generation. The default value for MIN is: 1. |
| Input | max | Optional. Parameter to set the maximum value for the unique number generation. The default value for MAX is: 1000000. |
| Output | mvar_name | Name of the global macro variable containing the last used integer sequence number value. The default value for MVAR_NAME is: _unique_nr. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Unique integer sequence number value.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_unique_number(?)
```

##### Example 2: Generate a unique integer value (result is: 1):
```sas
%let number=
  %m_utl_unique_number(
     debug = Y
     );
%put &=number.;

```

##### Example 3: Generate a unique integer value (result is: 2):
```sas
%let number=
  %m_utl_unique_number(
     debug = Y
     );
%put &=number.;

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
*This document was generated on 26.09.2023 at 15:42:01  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
