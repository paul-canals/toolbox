![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_delete_file.sas

### Utilities

##### Utility macro to delete a single file from the file system.

***

### Description
This program is to delete a single file. If failed, an error message will be thrown in the log and the run is terminated.

##### *Note:*
*This program is able to work in system environments where x-command or unix pipes are not allowed or cannot be used.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2021-01-25 00:00:00

### Version
* 21.1.01

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | file | Full qualified path and name of the to be deleted. The default value is: \_NONE\_. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Deleted single file

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_delete_file(?)
```

##### Example 2: Delete a single file:
```sas
filename text "%sysfunc(getoption(WORK))/delete_me.txt";

data _null_;
   file text;
   put "file to be deleted";
run;

filename text clear;

%m_utl_delete_file(
   file  = %sysfunc(getoption(WORK))/delete_me.txt
 , debug = Y
   );
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
*This document was generated on 12.02.2024 at 06:36:20  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v23.1.10)*
