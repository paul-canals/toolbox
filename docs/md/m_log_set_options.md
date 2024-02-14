![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_log_set_options.sas

### Logging

##### Logging macro to set the logging options between code blocks.

***

### Description
The macro toggles verbose mode logging on/off for debugging during execution. Valid values for MODE are:
 D or Debug
 N or Notes
 O or Off
 R or Reset
 S or Standard
 V or Verbose


### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-07-27 00:00:00

### Version
* 23.1.07

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | mode | Indicator [DEBUG/NOTES/OFF/STANDARD/VERBOSE] to set the logging options at the beginning of a code block, and optionally with [RESET] at the end of a code block to return to the previous log settings. The default value for MODE is: \_NONE\_. |
| Input | token | Parameter to specify an unique number that is used to identify the saved option variables in case this macro has been called more than once in a sequential chain during program execution. The default value for TOKEN is: 1; |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* None

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_log_set_options(?)
```

##### Example 2: Hide SAS data step statement from log:
```sas
options notes;

%m_log_set_options(
   mode  = OFF
 , debug = Y
   );

data _null_;
   put 'NOTE: This text will not be displayed';
run;

%m_log_set_options(
   mode  = RESET
 , debug = Y
   );

data _null_;
   put 'NOTE: This text will be displayed!';
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
*This document was generated on 2023.07.27 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
