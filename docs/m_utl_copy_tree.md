# File Reference: m_utl_copy_tree.sas

### Utilities

##### Utility macro to copy a folder tree with files to a location.

***

### Description
This program works for almost all filetypes since it uses the SAS PROC COPY procedure for SAS data types and a byte-for-byte approach to copy all other file types. The macro is also able to copy empty directories.

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
| Input | indir | Full path to the (root) directory to be copied from. The default value is: \_NONE\_. |
| Input | outdir | Full path to the (root) directory to be copied to. |
| Input | enckey | Optional. The encryption key, case when one or more input dataset are encrypted. The encryption key needs to be identical over the datasets. |
| Input | overwrite | Boolean [Y/N] parameter to decide if an existing copy is to be overwritten. The default value is: Y. |
| Input | subdirs | Boolean [Y/N] parameter to decide if the file list is to includes files in sub dir under ROOTDIR. The default value is: N. |
| Input | print | Boolean [Y/N] parameter to generate the output by a proc print step. The default value is: Y. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* The result tables WORK.TRG_FILE_DIFF and WORK.TRG_FILE_LIST

### Calls
* [m_utl_copy_file.sas](m_utl_copy_file.md)
* [m_utl_copy_sas_file.sas](m_utl_copy_sas_file.md)
* [m_utl_create_dir.sas](m_utl_create_dir.md)
* [m_utl_get_file_list.sas](m_utl_get_file_list.md)
* [m_utl_print_message.sas](m_utl_print_message.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_copy_tree(?)
```

##### Example 2: Copy SASUSER files and directory tree:
```sas
%m_utl_copy_tree(
   indir     = %sysfunc(pathname(SASHOME))/SASFoundation/9.4/sastest
 , outdir    = %sysfunc(getoption(WORK))/backup
 , enckey    =
 , overwrite = Y
 , subdirs   = Y
 , print     = Y
 , debug     = Y
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
*This document was generated on 27.09.2021 at 15:28:21  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
