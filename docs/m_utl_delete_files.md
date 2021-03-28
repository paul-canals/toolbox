![../misc/images/doc_banner.png](../misc/images/doc_banner.png)
# 
# File Reference: m_utl_delete_files.sas

### Utilities

##### Utility macro to delete all files from a given directory.

***

### Description
This program is to delete all files from a given directory, excluding files listed in the KEEP parameter.

##### *Note:*
*This program is able to work in system environments where x-command or unix pipes are not allowed or cannot be used.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-02-02 00:00:00

### Version
* 20.1.02

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | path | Full qualified to the directory from which the files are to be deleted. The default value is: \_NONE\_. |
| Input | keep | Optional. Parameter to indentify one or more files which are not to be deleted, separated by a blank. The default value is: \_NONE\_. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Deleted files from directory

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_quote_elems.sas](m_utl_quote_elems.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_delete_files(?)
```

##### Example 2: Delete files from a given directory:
```sas
options dlcreatedir;
libname TEMP "%sysfunc(getoption(WORK))/temp";
libname TEMP clear;

filename text1 "%sysfunc(getoption(WORK))/temp/delete_me.txt";

data _null_;
   file text1;
   put "file to be deleted";
run;

filename text1 clear;

filename text2 "%sysfunc(getoption(WORK))/temp/keep_me.txt";

data _null_;
   file text2;
   put "file to be deleted";
run;

filename text2 clear;

%m_utl_delete_files(
   path  = %sysfunc(getoption(WORK))/temp
 , keep  = keep_me.txt
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
*This document was generated on 28.03.2021 at 09:54:54  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.03)*
