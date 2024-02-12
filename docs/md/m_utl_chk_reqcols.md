![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_chk_reqcols.sas

### Utilities

##### Utility macro to check if requested columns exist in table.

***

### Description
The macro checks if a given list of required columns exist in a given SAS dataset or table. The macro returns a boolean value: the value 1 means that all columns are present in the
 table, and 0 when not all columns are present. This macro is originally based on the ut_reqcols_found.sas macro program by Dave Prinsloo (dave.prinsloo@yahoo.com)

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-11-13 00:00:00

### Version
* 23.1.11

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | table | Full LIBNAME.TABLENAME name of the or SAS dataset. The default value for TABLE is: \_NONE\_. |
| Input | rcols | List of columns separated by a blank character. The default value for RCOLS is: \_NONE\_. |
| Input | msg_text | Optional parameter to add additional information to the output text message when not all required columns are found in the given table. |
| Input | msg_type | Determines the severity of the message when not all required columns are found in the given table. The default value for MSG_TYPE is: ERR. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Either 1 or 0.

### Calls
* [m_utl_list_operation.sas](m_utl_list_operation.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_varlist.sas](m_utl_varlist.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_chk_reqcols(?)
```

##### Example 2: Check required columns "Name Sex Age" against Class dataset:
```sas
%let found=
   %m_utl_chk_reqcols(
      table    = SASHELP.class
    , rcols    = Name Sex Age
    , msg_text = PID:&sysjobid.
    , msg_type = WNG
    , debug    = Y
      );

%put &=found.;

```

##### Example 3: Check required columns "Name School" against Class dataset:
```sas
%let found=
   %m_utl_chk_reqcols(
      table    = SASHELP.class
    , rcols    = Name School
    , msg_text = PID:&sysjobid.
    , msg_type = OK
    , debug    = Y
      );

%put &=found.;

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
*This document was generated on 12.02.2024 at 06:36:08  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v23.1.10)*
