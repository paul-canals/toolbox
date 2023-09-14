![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_log_set_printto.sas

### Logging

##### Logging macro to set the SAS proc printto log output location.

***

### Description
This program sets the SAS proc printto log output destination to either an external log file or to the default log window. If the log output destination was already set to an external file, a printto list will be created so that the log output destination can be set back to its former state. This also works for nested printto log file statements. A notification with the full printto list of will be printed in the log file.

##### *Warning:*
*This macro is OBSOLETE: please use m_utl_printto.sas!*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-09-07 00:00:00

### Version
* 20.1.09

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | log_dest | Indicator [F/FILE/L/LOG] to specify the output log destination. If the parameter value is set to L or LOG, the output is set to the default log window destination. If the parameter value is set to F or FILE, the output is set to the output location set by the LOG_FILE parameter. The default value for LOG_DEST is: \_NONE\_. |
| Input | log_file | Specifies the directory path and name of the log file where the log output is to be written into. If the specified file does not exist it will be created, otherwise overwritten by default. The default value for LOG_FILE is: \_NONE\_. |
| Input | new_file | Optional. Boolean [Y/N] Parameter to specify wether to create a new log file, or to append to an already existing log file. The default value for NEW_FILE is: Y. |
| Input | prefix | Optional. Specifies a string added to the name of the output log file. |
| Input | subdirs | Optional. Boolean [Y/N] parameter to specify whether sub directories are created for to the root path containing yaer and month information (yyyy/mm/).The default value for SUBDIRS is: N. |
| Input | timestamp | Optional. Boolean [Y/N] parameter to specify whether timstamp information (yyyymmdd_hhmmss) is added to the name of the output log file. The default value for TIMESTAMP is: N. |
| Input | global_flg | Boolean [Y/N] Parameter to specify wether the MVAR_NAME parameter value is to be declared as a global macro variable. If the parameter value is set to N, MVAR_NAME is not returned outside the macro. The default value is: N. |
| Output | mvar_name | Name of the global macro variable containing the result value representing the log output destination. The default value is: _printto. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Destination output LOG or Log file.

### Calls
* [m_utl_create_dir.sas](m_utl_create_dir.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_log_set_printto(?)
```

##### Example 2: Set the proc printto log output destination to a file:
```sas
%m_log_set_printto(
   log_dest = FILE
 , log_file = %str(%sysfunc(getoption(WORK))/output.log)
 , debug    = Y
   );

data WORK.class;
   set SASHELP.class;
run;

%m_log_set_printto(
   log_dest = LOG
 , debug    = Y
   );

%put PRINT LOG_FILE:;

filename log_file "%sysfunc(getoption(WORK))/output.log";

data _null_;
   infile log_file;
   input;
   put _infile_;
run;

```

##### Example 3: Set the proc printto log output to a file with prefix:
```sas
%m_log_set_printto(
   log_dest = FILE
 , log_file = %str(%sysfunc(getoption(WORK))/output.log)
 , prefix   = Test
 , debug    = Y
   );

data WORK.class;
   set SASHELP.class;
run;

%m_log_set_printto(
   log_dest = LOG
 , debug    = Y
   );

%put PRINT LOG_FILE:;

filename log_file "%sysfunc(getoption(WORK))/test_output.log";

data _null_;
   infile log_file;
   input;
   put _infile_;
run;

```

##### Example 4: Set the proc printto log output to a file with timestamp in name:
```sas
%m_log_set_printto(
   log_dest   = FILE
 , log_file   = %str(%sysfunc(getoption(WORK))/output.log)
 , timestamp  = Y
 , global_flg = Y
 , mvar_name  = _printto_file
 , debug      = Y
   );

data WORK.class;
   set SASHELP.class;
run;

%m_log_set_printto(
   log_dest = LOG
 , debug    = Y
   );

%put PRINT LOG_FILE:;

filename log_file "&_printto_file.";

data _null_;
   infile log_file;
   input;
   put _infile_;
run;

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
*This document was generated on 13.09.2023 at 19:02:06  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
