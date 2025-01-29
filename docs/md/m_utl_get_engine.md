[![../../misc/images/doc_header.png](../../misc/images/doc_header.png)](#)
# 
# File Reference: m_utl_get_engine.sas

### Utilities

##### Utility macro to get the engine name of a given SAS library.

***

### Description
The macro searches the SAS dictionary tables to find the engine information of the given SAS library reference. The library reference parameter LIBREF may also contain table information to retrieve the engine value from the libname.tablename level. This can be usefull in case of SAS SQL or SAS data-step Views. See also Usage Example 4.



##### *Note:*
*This macro is originally based on getEngine.sas() macro program by Chris Hemedinger (chris.hemedinger@sas.com), and Peter Crawford (peter.crawford@blueyonder.co.uk).*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)
* Dr. Simone Kossmann (simone.kossmann@web.de)

### Date
* 2024-10-28 00:00:00

### Version
* 24.1.10

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | libref | Name of the the engine should be checked. The default value is: \_NONE\_. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* The engine name of the given SAS library reference.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_get_engine(?)
```

##### Example 2: Get engine information for SASHELP:
```sas
%let engine =
   %m_utl_get_engine(
      libref = SASHelp
    , debug  = N
      );
%put &=engine.;
```

##### Example 3: Get engine information for SASHELP.cars:
```sas
%let engine =
   %m_utl_get_engine(
      libref = SASHELP.cars
    , debug  = N
      );
%put &=engine.;
```

##### Example 4: Get engine information for SASHELP.vmacro:
```sas
%let engine =
   %m_utl_get_engine(
      libref = SASHELP.vmacro
    , debug  = N
      );
%put &=engine.;
```

##### Example 5: Get engine information for WORK.cars:
```sas
data WORK.cars/view=WORK.cars;
   set SASHELP.cars;
run;

%let engine =
   %m_utl_get_engine(
      libref = WORK.cars
    , debug  = N
      );
%put &=engine.;
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
*This document was generated on 2024.10.28 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
