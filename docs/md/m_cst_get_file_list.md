![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_cst_get_file_list.sas

### Custom

##### Custom macro to obtain file and sub directory tree information.

***

### Description
This is a standalone macro program to list all files in a given root directory, and sub-directories. The rsult of this macro are two tables containing the file and directory structure information, including level to identify the number of sub directories below the root directory. If a file is locked, the macro still produces a record into the FILE_LIST dataset and column LOCKED gets a value Y, but no file size, creation time or last modified date is set.



##### *Note:*
*This program is able to work in system environments where x-command or unix pipes are not allowed or cannot be used.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-05-19 00:00:00

### Version
* 24.1.05

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | rootdir | Full path to the root directory for the file list. The default value for ROOTDIR is: \_NONE\_; |
| Input | level | The of the current directory to the ROOTDIR. The default value for LEVEL is: 0. |
| Input | prefix | The added to the names of the output tables. The default value for PREFIX is: _SRC. |
| Input | subdirs | Boolean [Y/N] parameter to specify if the file list includes files in sub folders under ROOTDIR. The default value for SUBDIRS is: N. |
| Input | finfo | Boolean [Y/N] parameter to specify additional information to be added to the file list. This information includes the file size, the creation date and time, and the last modification date and time. The default value for FINFO is: N. |
| Input | print | Boolean [Y/N] parameter to generate the output by a SAS proc report step with style HtmlBlue. The default value for PRINT is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Returns tables containing the rootdir directory and file list.

### Calls
* None

### Usage

##### Example 1: Show help information:
```sas
%m_cst_get_file_list(?)
```

##### Example 2: List files and dirs in current WORK directory:
```sas
%m_cst_get_file_list(
   rootdir = %sysfunc(getoption(WORK))
 , level   = 0
 , prefix  = src_
 , subdirs = Y
 , finfo   = Y
 , print   = Y
 , debug   = Y
   );
```

##### Example 3: List files and dirs in sasroot/maps directory:
```sas
%m_cst_get_file_list(
   rootdir = %sysget(SASROOT)/maps
 , prefix  = src_
 , subdirs = N
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
*This document was generated on 2024.05.19 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
