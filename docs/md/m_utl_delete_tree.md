![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_delete_tree.sas

### Utilities

##### Utility macro to delete a given directory, files and sub dirs.

***

### Description
This program recursively deletes the given directory, files and optionally any child directories. If failed, an error message will be thrown in the log and the run is terminated.

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
| Input | path | Full to the (root) directory to be deleted. The default value is: \_NONE\_. |
| Input | subdirs | Boolean [Y/N] parameter to decide if the files and sub dirs under PATH are to be deleted too. The default value is: N. |
| Input | print | Boolean [Y/N] parameter to generate the output by a proc print step. The default value is: Y. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Recursively deleted files and directories

### Calls
* [m_utl_delete_dir.sas](m_utl_delete_dir.md)
* [m_utl_delete_file.sas](m_utl_delete_file.md)
* [m_utl_get_file_list.sas](m_utl_get_file_list.md)
* [m_utl_print_message.sas](m_utl_print_message.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_delete_tree(?)
```

##### Example 2: Delete all files and dirs from a given path directory:
```sas
options dlcreatedir;
libname TEMP "%sysfunc(getoption(WORK))/tmpdir";
libname TEMP clear;

filename text1 "%sysfunc(getoption(WORK))/tmpdir/delete_1.txt";

data _null_;
   file text1;
   put "file to be deleted";
run;

filename text1 clear;

filename text2 "%sysfunc(getoption(WORK))/tmpdir/delete_2.txt";

data _null_;
   file text2;
   put "file to be deleted";
run;

filename text2 clear;

libname TEMP "%sysfunc(getoption(WORK))/tmpdir/subdir";
libname TEMP clear;

filename text3 "%sysfunc(getoption(WORK))/tmpdir/subdir/delete_3.txt";

data _null_;
   file text3;
   put "file to be deleted";
run;

filename text3 clear;

%m_utl_delete_tree(
   path    = %sysfunc(getoption(WORK))/tmpdir
 , subdirs = Y
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
*This document was generated on 13.09.2023 at 15:25:53  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
