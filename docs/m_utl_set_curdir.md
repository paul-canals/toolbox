# File Reference: m_utl_set_curdir.sas

### Utilities

##### Utility macro to change the current SAS directory physical name.

***

### Description
This program changes for the current working directory using a filename reference in combination with the pathname and dlgcdir functions to identify and change the value during a SAS session. The result is returned inline, and a global SAS macro variable named _SASWORKINGFOLDER is set with the current changed value. This macro is based on the curdir macro by Tom Hoffman and Fan Zhou to which I stumbled upon reading at communities.sas.com.

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
| Input | path | Full of the directory to be set as current working directory. If this value is omitted, the initial working directory will be set as current. The default value for PATH is: \_NONE\_. |
| Output | mvar_name | Name of the global macro variable containing the SAS current working directory path name. The default value is: _SASWORKINGFOLDER. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* The current SAS directory physical name.

### Calls
* [m_utl_get_curdir.sas](m_utl_get_curdir.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_set_curdir(?)
```

##### Example 2: Get the current SAS directory physical path name:
```sas
%let curdir = %m_utl_set_curdir(debug=Y);
%put &=curdir.;

%put &=_sasinitialfolder.;
%put &=_sasworkingfolder.;
```

##### Example 3: Set the current SAS directory physical path name:
```sas
%let curdir =
   %m_utl_set_curdir(
      path = %sysfunc(pathname(sasuser))/Data
    , debug = Y
      );
%put &=curdir.;

%put &=_sasinitialfolder.;
%put &=_sasworkingfolder.;
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
*This document was generated on 30.10.2022 at 09:13:33  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
