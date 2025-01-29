[![../../misc/images/doc_header.png](../../misc/images/doc_header.png)](#)
# 
# File Reference: m_sys_job_group.sas

### System

##### System macro to run a chain of SAS DI-Jobs sequentially.

***

### Description
The macro runs a chain of SAS DI-Jobs sequentially for batch processing using a job wrapper for documenting the results and rerouting the log for each job.



### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-10-06 00:00:00

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
| Input | job_1-10 | List of up to ten job files, excluding the .SAS file extention. |
| Input | limit | Indicator [0/4/99999] to specify if warnings or errors are allowed during runtime. Normally no errors or warnings are allowed (ERR_LIMIT = 0). If warnings are allowed, then set ERR_LIMIT = 4. If all is allowed, set the ERR_LIMIT to 99999. The default value for ERR_LIMIT is: 0. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Group of SAS DI Jobs run in sequence

### Calls
* [m_log_set_options.sas](m_log_set_options.md)
* [m_sys_job_wrapper.sas](m_sys_job_wrapper.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_unique_number.sas](m_utl_unique_number.md)

### Usage

##### Example 1 - Step 1: Create an example job:
```sas
%let rc = %sysfunc(filename(fref,.));
%let cd = %sysfunc(pathname(&fref.));
%let rc = %sysfunc(filename(fref));

filename tmp "&cd./../SASMeta/SASEnvironment/SASCode/Jobs/Hello_World.sas";
data _null_;
   file tmp;
   put '*Show in log:;';
   put '%put HELLO WORLD!;';
   put 'data _null_;';
   put '   rc=sleep(2);';
   put 'run;';
run;

filename tmp "&cd./../SASMeta/SASEnvironment/SASCode/Jobs/Goodbye_Job.sas";
data _null_;
   file tmp;
   put '*Show in log:;';
   put '%put Goodbye Job!;';
   put 'data _null_;';
   put '   rc=sleep(2);';
   put 'run;';
run;

filename tmp clear;

```

##### Example 1 - Step 2: Run the example job group:
```sas
%let rc = %sysfunc(filename(fref,.));
%let cd = %sysfunc(pathname(&fref.));
%let rc = %sysfunc(filename(fref));

%m_sys_job_group(
   job_path = &cd./../SASMeta/SASEnvironment/SASCode/Jobs
 , log_path = &cd./../SASMeta/SASEnvironment/SASCode/Logs
 , job_1    = Hello_World
 , job_2    = Goodbye_Job
 , debug    = N
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
*This document was generated on 2023.10.06 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
