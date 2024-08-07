![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_utl_xpt2ds.sas

### Utilities

##### Utility macro to import a XPT transport file to a SAS dataset.

***

### Description
This program converts a SAS transport (XPT) file into a SAS dataset. The macro is able to handle V5 transport files written by the SAS XPORT engine. It should also be able to handle V8 or V9 extended transport files created by companion ds2xpt macro.



### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-10-07 00:00:00

### Version
* 23.1.10

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | in_file | Specifies the name and location of the transport file with XPT extension. The default value for IN_FILE is: \_NONE\_. |
| Input | out_lib | Specifies the full name of the output library reference name. The default value is: \_NONE\_. |
| Input | memlist | Specifies a space separated list of dataset members to be imported from the input file. The default value for MEMLIST is: _ALL_. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Output SAS dataset.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_xpt2ds(?)
```

##### Example 2: Step 1 - Export the CLASS table to a default XPT file named class.xpt:
```sas
%loc2xpt(
   libref   = SASHELP
 , memlist  = class
 , filespec = %unquote(%bquote('%sysfunc(getoption(WORK))/class.xpt'))
 , format   = AUTO
   );
```

##### Example 2: Step 2 - Import the class.xpt transport file into a SAS dataset:
```sas
%m_utl_xpt2ds(
   in_file = %str(%sysfunc(getoption(WORK))/class.xpt)
 , out_lib = WORK
 , memlist = _ALL_
 , debug   = Y
   );

proc print data=WORK.class;
run;
```

##### Example 3: Step 1 - Export the CLASS table to an extended XPT file named class.xpt:
```sas
%loc2xpt(
   libref   = SASHELP
 , memlist  = class
 , filespec = %unquote(%bquote('%sysfunc(getoption(WORK))/class.xpt'))
 , format   = V9
   );
```

##### Example 3: Step 2 - Import the class.xpt transport file into a SAS dataset:
```sas
%m_utl_xpt2ds(
   in_file = %str(%sysfunc(getoption(WORK))/class.xpt)
 , out_lib = WORK
 , memlist = _ALL_
 , debug   = Y
   );

proc print data=WORK.class;
run;
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
*This document was generated on 2023.10.07 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
