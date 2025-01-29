[![../../misc/images/doc_header.png](../../misc/images/doc_header.png)](#)
# 
# File Reference: m_utl_chk_boolean.sas

### Utilities

##### Utility macro to check and convert a given boolean flag value.

***

### Description
The program checks if the given BOOL boolean attribute value is in a list of common used boolean values to determine the result true/false boolean values set by B_TRUE and B_FALSE. The result boolean value is returned inline (inline macro).

 Valid common input boolean values:

- TRUE: [1, e, j, o, s, y, E, J, O, S, Y, True]
- FALSE: [0, h, n, H, N, False]



##### *Note:*
*Toolbox global macro variables M_YES_FLG and M_NO_FLG can be used to set additional boolean Y/N pair values defined in the toolbox/config/run_parameter_ctrl.csv file.*

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
| Input | bool | Input boolean true/false value to be checked. The default value fer BOOL is: \_NONE\_. |
| Input | b_true | Return boolean true value. The default value is: Y. |
| Input | b_false | Return boolean false value. The default value is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Result inline checked and converted boolean value.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_chk_boolean(?)
```

##### Example 2: Check boolean value for DEBUG=Y (German "J"):
```sas
%let debug =
   %m_utl_chk_boolean(
      bool  = %str(Ja)
    , debug = Y
      );

%put &=debug.;

```

##### Example 3: Check boolean value for DEBUG=N (Turkish "Hadir"):
```sas
%let debug =
   %m_utl_chk_boolean(
      bool  = %str(H)
    , debug = Y
      );

%put &=debug.;

```

##### Example 4: Convert true/false boolean value 1 to BOOL=Y:
```sas
%let bool =
   %m_utl_chk_boolean(
      bool  = 1
    , debug = Y
      );

%put &=bool.;

```

##### Example 5: Convert true/false boolean value 1 to BOOL=true:
```sas
%let bool =
   %m_utl_chk_boolean(
      bool    = 1
    , b_true  = true
    , b_false = false
    , debug   = Y
      );

%put &=bool.;

```

##### Example 6: Convert true/false boolean value true to BOOL=1:
```sas
%let debug = J;

%let bool =
   %m_utl_chk_boolean(
      bool    = true
    , b_true  = 1
    , b_false = 0
    , debug   = %m_utl_chk_boolean(bool=&debug.)
      );

%put &=bool.;

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
