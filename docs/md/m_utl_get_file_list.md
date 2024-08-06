![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_get_file_list.sas

### Utilities

##### Utility macro to obtain file and sub directory tree information.

***

### Description
This program creates two tables containing file and directory structure information, including level to identify the number of sub directories below the root directory. If a file is write-locked the macro still produces a record into the FILE_LIST dataset and column LOCKED gets a value Y, but no file size, creation time or last modified date is set.



##### *Note:*
*This program is able to work in system environments where x-command or unix pipes are not allowed or cannot be used.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-07-26 00:00:00

### Version
* 24.1.07

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | rootdir | Full path to the root directory for the file list. |
| Input | level | The  of the current directory to the ROOTDIR. |
| Input | prefix | The  added to the names of the output tables. |
| Input | subdirs | Boolean [Y/N] parameter to specify if the file list includes files in sub folders under ROOTDIR. The default value for SUBDIRS is: N. |
| Input | finfo | Boolean [Y/N] parameter to specify additional information to be added to the file list. This information includes the file size, the creation date and time, and the last modification date and time. The default value for FINFO is: N. |
| Input | print | Boolean [Y/N] parameter to generate the output by a proc print step. The default value is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* WORK.[SRC|PREFIX]_DIR_LIST
* WORK.[SRC|PREFIX]_FILE_LIST

### Calls
* [m_log_set_options.sas](m_log_set_options.md)
* [m_utl_delete_file.sas](m_utl_delete_file.md)
* [m_utl_nlobs.sas](m_utl_nlobs.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_printto.sas](m_utl_printto.md)
* [m_utl_unique_number.sas](m_utl_unique_number.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_get_file_list(?)
```

##### Example 2: List files and dirs in current WORK directory:
```sas
%m_utl_get_file_list(
   rootdir = %sysfunc(getoption(WORK))
 , level   = 0
 , prefix  = src_
 , subdirs = Y
 , finfo   = Y
 , print   = Y
 , debug   = Y
   );
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
*This document was generated on 2024.07.26 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
