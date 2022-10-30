# File Reference: m_sys_job_error.sas

### System

##### System macro to write job error messages to a control table.

***

### Description
The macro checks the result status of a SAS DI-Job, and if an error occurred, it writes a protocol as a new entry in a SAS dataset or database table.

##### *Note:*
*All parameters with <b>p_</b> prefix are optional when the macro is used in a SAS Data Integration Studio job, since the parameter variables will be filled automatically.*

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
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | ctl_table | Full LIBNAME.TABLENAME name of the JOB_ERROR SAS dataset or table. |
| Input | p_etls_user | The name or id of the user executing the code. |
| Input | p_etls_name | Name of the SAS job |
| Input | p_etls_vers | SAS version |
| Input | p_job_rc | Job Return Code |
| Input | p_job_dttm | Optional. Date Time (SAS numeric datetime) |
| Input | p_syscc | System Return Code |
| Input | p_msg | Optional. Custom system return message string |
| Input | p_load_dttm | Optional. Date Time (SAS numeric datetime) |
| Input | p_trans_rc | Transaction Return Code |
| Input | p_sqlrc | SQL Return Code |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* JOB_ERROR table created and/or updated

### Calls
* [m_utl_clr_table_lock.sas](m_utl_clr_table_lock.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_set_table_lock.sas](m_utl_set_table_lock.md)

### Usage

##### Example 1: Show help information:
```sas
%m_sys_job_error(?)
```

##### Example 2: Create an example entry in the JOB_ERROR table:
```sas
%let etls_jobname = %nrquote(TEST_JOB);
%let job_rc = 4;
%let msg_rc = custom_rc4_msg;
%let trans_rc = 0;
%let sqlrc = 0;

%m_sys_job_error(
   ctl_table    = WORK.job_error
 , p_etls_user  = &sysuserid.
 , p_etls_name  = &etls_jobname.
 , p_etls_vers  = &sysver.
 , p_job_rc     = &job_rc.
 , p_syscc      = &syscc.
 , p_syserr     = &syserr.
 , p_message    = &msg_rc.
 , p_load_dttm  =
 , p_trans_rc   = &trans_rc.
 , p_sqlrc      = &sqlrc.
 , debug        = N
   );

proc print data=WORK.job_error label;
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
*This document was generated on 30.10.2022 at 09:11:56  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
