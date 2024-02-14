![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_print_message.sas

### Utilities

##### Utility macro for printing a program status return message.

***

### Description
This program prints a status message to either the SAS log output or the result destination. SAS proc report is used to print a status message in the SAS Enterprise Guide or SAS Stored Process result tab.

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-11-12 00:00:00

### Version
* 20.1.11

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | program | The full name of the macro to which the print message program refers to. |
| Input | status | Indicator [DEBUG/ERR/INFO/OK/WNG] to specify the status type of the program message to display. The default value for STATUS is: OK. |
| Input | message | Status  test string (max. 100 characters). |
| Input | print | Boolean [Y/N] parameter to generate the output by a SAS proc report step with style HtmlBlue. The default value for PRINT is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Status message printed to the log or result output destination.

### Calls
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_print_message(?)
```

##### Example 2: Print a successful message to the result output:
```sas
%m_utl_print_message(
   program = &sysmacroname.
 , status  = OK
 , message = %quote(Macro &sysmacroname. has run successfully.)
 , print   = Y
 , debug   = Y
   );
```

##### Example 3: Print a warning message to the log:
```sas
%m_utl_print_message(
   program = &sysmacroname.
 , status  = WNG
 , message = %quote(Macro &sysmacroname. has ended with warnings!)
 , debug   = Y
   );
```

##### Example 4: Print an error message to the result output:
```sas
%m_utl_print_message(
   program = &sysmacroname.
 , status  = ERR
 , message = %quote(Macro &sysmacroname. has ended with errors!)
 , print   = Y
 , debug   = Y
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
*This document was generated on 2020.11.12 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
