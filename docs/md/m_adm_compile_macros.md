![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_adm_compile_macros.sas

### Admin

##### Admin macro to compile macros into a SAS macro catalog.

***

### Description
The macro lists all SAS macros from a selected directory and adds them into a SAS macro catalog using secured compilation. The result information is presented by a SAS Proc Report step and can be send by email as an PDF format attachment.

##### *Note:*
*All macros containing m_adm_compile or m_utl_mstore as prefix are excluded during the macro catalog compilation execution.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2021-01-23 00:00:00

### Version
* 21.1.01

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | indir | Specifies the full path to the input directory containing the source SAS macro programs. The default value is: \_NONE\_. |
| Input | outdir | Specifies the full path to the output SAS macro catalog. The default value is: \_NONE\_. |
| Input | exclude | Optional. Specifies a chararter string to filter macros by name which should be excluded from the macro compilation. |
| Input | print | Boolean [Y/N] parameter to generate the output by a proc report step with style HtmlBlue. The default value is: Y. |
| Input | sendmail | Boolean [Y/N] parameter to decide if the result information list is to be send to email address. The default value is: N. |
| Input | mailaddr | Send to email address of private person or group. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* WORK.USER_GROUPS

### Calls
* [m_utl_create_dir.sas](m_utl_create_dir.md)
* [m_utl_get_file_list.sas](m_utl_get_file_list.md)
* [m_utl_mail_notification.sas](m_utl_mail_notification.md)
* [m_utl_mstore_add.sas](m_utl_mstore_add.md)
* [m_utl_mstore_view.sas](m_utl_mstore_view.md)
* [m_utl_nlobs.sas](m_utl_nlobs.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_adm_compile_macros(?)
```

##### Example 2: Compile macros to a catalog and print report result:
```sas
%m_adm_compile_macros(
   indir    = %str(&APPL_PRGM.)
 , outdir   = %sysfunc(getoption(WORK))/catalog
 , exclude  = m_test
 , print    = Y
 , debug    = Y
   );
```

##### Example 3: Compile macros to a catalog and send report by email:
```sas
%m_adm_compile_macros(
   indir    = %str(&APPL_PRGM.)
 , outdir   = %sysfunc(getoption(WORK))/catalog
 , exclude  = m_test_execute_scripts
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
 , debug    = Y
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
*This document was generated on 13.09.2023 at 15:24:39  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
