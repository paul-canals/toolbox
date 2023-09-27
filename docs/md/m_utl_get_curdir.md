![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_get_curdir.sas

### Utilities

##### Utility macro to obtain the current SAS directory physical name.

***

### Description
This program searches for the current working directory using a filename reference in combination with the pathname function. The result is returned inline, and a global SAS macro variable named _SASINITIALFOLDER is set initially with the current value. This macro is based on the curdir macro by Tom Hoffman and Fan Zhou to which I stumbled upon reading at communities.sas.com.

##### *Note:*
*This program is able to work in system environments where x-command or unix pipes are not allowed or cannot be used.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2021-11-05 00:00:00

### Version
* 21.1.11

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Output | mvar_name | Name of the global macro variable containing the initial SAS current directory path name. The default value is: _SASINITIALFOLDER. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* The current SAS directory physical name.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_get_curdir(?)
```

##### Example 2: Get the current SAS directory physical path name:
```sas
%let curdir = %m_utl_get_curdir(debug = Y);
%put &=curdir.;

%put &=_sasinitialfolder.;
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
*This document was generated on 26.09.2023 at 15:41:01  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
