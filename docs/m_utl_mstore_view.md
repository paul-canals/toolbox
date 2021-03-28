![../misc/images/doc_banner.png](../misc/images/doc_banner.png)
# 
# File Reference: m_utl_mstore_view.sas

### Utilities

##### Utility macro to list the contents of a SAS macro catalog.

***

### Description
This program lists the contents of a SAS macro catalog in the procedure output or writes a list of the contents or a filtered selection to a SAS dataset or database table.

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-10-01 00:00:00

### Version
* 20.1.10

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | indir | Specifies the full path to the SAS macro catalog. The default value is: \_NONE\_. |
| Input | outds | Specifies the full LIBNAME.TABLENAME name of the output SAS dataset or database table containing the result content. The default value is: \_NONE\_. |
| Input | where | Specifies a WHERE clause that selects only valid observations from the output dataset. Using this argument subsets your data based on the criteria that you supply for where-expression. |
| Input | print | Boolean [Y/N] parameter to generate the output by a proc print step. The default value is: Y. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* The contents of a SAS macro catalog.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_mstore_view(?)
```

##### Example 2: Lists the contents of a macro catalog to a SAS dataset:
```sas
%m_utl_mstore_view(
   indir = %str(%sysget(SASROOT)/core/sashelp)
 , print = Y
 , debug = Y
   );
```

##### Example 3: Lists the contents of a macro catalog to a SAS dataset:
```sas
%m_utl_mstore_view(
   indir = %str(%sysget(SASROOT)/core/sashelp)
 , outds = WORK.result
 , where = %str(upcase(Name) contains 'EVA_')
 , print = Y
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
*This document was generated on 28.03.2021 at 09:56:14  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.03)*
