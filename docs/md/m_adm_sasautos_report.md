![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_adm_sasautos_report.sas

### Admin

##### Admin macro to create the SASAUTO macro members report.

***

### Description
The macro collects all SAS macro names from various directories and filerefs returned by the GETOPTION and PATHNAME (SASAUTOS) functions. It examines WORK.SASMACR, and other SASMACR catalogs returned by pathname(getoption(SASMSTORE)). The macro lists the .SAS files and catalog macro objects found within directories surfaced by:
 getoption('sasautos') \-> SASAUTOS altered by options statement
 pathname('sasautos') \-> SASAUTOS config file definition
 filerefs/catalogs found within SASAUTOS definitions
 pathname(getoption('sasmstore')) \-> compiled macros.
 This macro is originally based on the list_sasautos.sas macro from Harry Droogendyk (harry@stratia.ca) and enhancements made by Dave Prinsloo (dave.prinsloo@yahoo.com)

##### *Note:*
*Not every module found within these directories is necessarily a macro definition. Furthermore, this macro does NOT open files to verify the presence of the required "macro" statement.*

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
| Input | work_flg | Boolean [Y/N] parameter to show or hide macro entries from Work library macro catalogs in the result list. The default value is: Y. |
| Input | select | Indicator [_ALL_/COMP/DUP/NODUP] to filter the output result list. Valid selection values are: COMP for selecting only compiled macros, DUP for selecting only duplicates, NODUP for selecting all unique and active macros and finally _ALL_ to create a list of all existing macro members. The dafault value for SELECT is: _ALL_. |
| Input | print | Boolean [Y/N] parameter to generate the output by a proc report step with style HtmlBlue. The default value is: N. |
| Input | sendmail | Boolean [Y/N] parameter to decide if the result information list is to be send to email address. The default value is: N. |
| Input | mailaddr | Send to email address of private person or group. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* A list of all macro programs found on the system

### Calls
* [m_utl_mail_notification.sas](m_utl_mail_notification.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_adm_sasautos_report(?);
```

##### Example 2: Select all macros and create report list:
```sas
%m_adm_sasautos_report(
   work_flg    = Y
 , print       = Y
 , debug       = Y
   );
```

##### Example 3: Select compiled macros and create report:
```sas
%m_adm_sasautos_report(
   work_flg    = Y
 , select      = COMP
 , print       = Y
   );
```

##### Example 4: Select duplicate macros and create report:
```sas
%m_adm_sasautos_report(
   work_flg    = Y
 , select      = DUP
 , print       = Y
   );
```

##### Example 5: Select unique macros and send report by email:
```sas
%m_adm_sasautos_report(
   work_flg    = Y
 , select      = NODUP
 , sendmail    = Y
 , mailaddr    = %str(pact@hermes.local)
   );
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
*This document was generated on 13.09.2023 at 19:01:44  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
