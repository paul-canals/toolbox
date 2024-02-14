![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_random_number.sas

### Utilities

##### Utility macro to generate a random integer number value.

***

### Description
The macro generates a random (integer) number between a given minimum and maximum values using SAS floor and rand functions.

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2021-01-23 00:00:00

### Version
* 21.1.01

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | min | Optional. Parameter to set the minimum value for the random number generation. The default value for MIN is: 1. |
| Input | max | Optional. Parameter to set the maximum value for the random number generation. The default value for MAX is: 1000000. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Random integer number value.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_random_number(?)
```

##### Example 2: Generate a random integer value between 1 and 1000:
```sas
%let number=
  %m_utl_random_number(
     debug = Y
     );
%put &=number.;
```

##### Example 3: Generate a random integer value between 1 and 100:
```sas
%let number=
  %m_utl_random_number(
     min   = 1
   , max   = 100
   , debug = Y
     );
%put &=number.;
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
*This document was generated on 2021.01.23 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
