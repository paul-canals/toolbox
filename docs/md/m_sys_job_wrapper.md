![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_sys_job_wrapper.sas

### System

##### System macro to encapsulate SAS DI-Job for batch processing.

***

### Description
The macro incapsulates a SAS DI-Job for execution and processing in batch. It collects run time information and creates a log with detailed information.



### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-10-07 00:00:00

### Version
* 23.1.10

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | job_path | Full path to the SAS DI-Jobs generated sas code. |
| Input | log_path | Full path to the SAS DI-Jobs log file directory. |
| Input | job_name | Job file Name, excluding the .SAS extention. |
| Input | global_flg | Boolean [Y/N] Parameter to declare if the logfile variable is to be declared globally. The Default value is: N. |
| Output | mvar_name | Name of the global variable containing the logfile name and full path. The default value is: M_JOB_LOG. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* None

### Calls
* [m_log_set_options.sas](m_log_set_options.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_print_file.sas](m_utl_print_file.md)
* [m_utl_printto.sas](m_utl_printto.md)
* [m_utl_unique_number.sas](m_utl_unique_number.md)

### Usage

##### Example 1 - Step 1: Create an example job:
```sas
%let rc = %sysfunc(filename(fref,.));
%let cd = %sysfunc(pathname(&fref.));
%let rc = %sysfunc(filename(fref));

filename tmp "&cd./../SASMeta/SASEnvironment/SASCode/Jobs/Hello_World.sas";
data _null_;
   file tmp mod;
   put '*Show in log:;';
   put '%put HELLO WORLD!;';
run;

```

##### Example 1 - Step 2: Run the example job:
```sas
%m_sys_job_wrapper(
   job_path   = &cd./../SASMeta/SASEnvironment/SASCode/Jobs
 , log_path   = &cd./../SASMeta/SASEnvironment/SASCode/Logs
 , job_name   = Hello_World
 , global_flg = Y
 , mvar_name  = M_JOB_LOG
 , debug      = N
   );

%put LOG=&M_JOB_LOG.;

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
*This document was generated on 2023.10.07 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
