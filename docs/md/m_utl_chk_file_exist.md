![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_utl_chk_file_exist.sas

### Utilities

##### Utility macro to check if a file exists and can be opened.

***

### Description
The program checks if an external file exists and can be opened for reading and/or writing. The result is returned inline. The valid RESULT values are:

- RESULT \=  1 : File exists and can be opened.
- RESULT \=  0 : File does not exist.
- RESULT \= \-1 : File exists, but can not be opened.



##### *Note:*
*The SHOW_ERR parameter shows or suppresses possible warnings or errors in the SAS log output destination.*

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
| Input | infile | Full path and file name of the external source file. The default value is: \_NONE\_. |
| Input | show_err | Boolean [Y/N] parameter to show or hide warnings or errors in the log. The default value is: Y. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Result inline macro value.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_chk_file_exist(?)
```

##### Example 2: File exists and can be opened (RESULT=1):
```sas
%let fileExist =
   %m_utl_chk_file_exist(
      infile   = %sysfunc(pathname(sasroot))/sasv9.cfg
    , show_err = Y
    , debug    = Y
      );

%put &=fileExist.;

```

##### Example 3: File does not exist (RESULT=0):
```sas
%let fileExist =
   %m_utl_chk_file_exist(
      infile   = %sysfunc(pathname(sasroot))/sasv8.cfg
    , show_err = N
    , debug    = Y
      );

%put &=fileExist.;

```

##### Example 4: File exists, but can not be opened (RESULT=-1):
```sas
%let fileExist =
   %m_utl_chk_file_exist(
      infile   = %sysfunc(getoption(WORK))/sasgopt.sas7bcat
    , show_err = N
    , debug    = Y
      );

%put &=fileExist.;

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
