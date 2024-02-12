![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_get_userid.sas

### Utilities

##### Utility macro to obtain the user id from the current session.

***

### Description
The macro checks the current SAS session for the existance of the following SAS system macro variables (ordered list):
 _METAPERSON : valid in context of SAS Stored Process Server
 _METAUSER : valid in context of SAS Workspace Server
 SYSUSERID : valid in context of local SAS or batch


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
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | global_flg | Boolean [Y/N] Parameter to specify wether the result value is to be declared as a global macro variable. If set to N, the result is only returned inline. The default value for GLOBAL is: N. |
| Output | mvar_name | Name of the global SAS macro variable containing the result value representing the found user ID. The default value for MVAR_NAME is: _userid. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* The User ID e.g. owner of the current SAS session.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_get_userid(?)
```

##### Example 2: Get the user id e.g. owner of the current session (Inline):
```sas
data _null_;
   userid = "%m_utl_get_userid(debug=Y)";
   put userid=;
run;

```

##### Example 3: Get the user id e.g. owner of the current session (Global):
```sas
%global userid;

%m_utl_get_userid(
   global_flg = Y
 , mvar_name  = userid
 , debug      = Y
   );

%put &=userid.;

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
*This document was generated on 12.02.2024 at 06:36:54  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v23.1.10)*
