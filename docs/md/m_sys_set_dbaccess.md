![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_sys_set_dbaccess.sas

### System

##### System macro to set the SAS user access to DBMS and SAS librefs.

***

### Description
This macro sets the SAS user specific database and SAS libref connections from the DBACCESS table. If there are any problems with setting a user connection, an email notification is send to inform the user and admin group. If the problem is due to an invalid user password combination, the dbms entry is set to inactive in the DBACCESS table using the m_sys_upd_dbaccess.sas macro routine.

##### *Note:*
*The SAS dataset containing the database connection profiles has to be named DBACCESS since all the routines expects this.*
*If you lose or forget the ENCRYPTKEY, there will be absolutely no way to open the DBACCESS table and recover the data!*

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
| Input | dstable | Full qualified table name <LIBNAME.dbaccess>. |
| Input | dskey | Value of the ENCRYPTKEY parameter. The minimum string length needs to be 8 characters long. |
| Input | list | Parameter to specify a of one or more libref or database connection (DBNAME) or package name (DBPACK) entries. If given more than one entry, the LIST should contain quoted entries and comma separation. (e.g.\ ('SASHELP','SASUSER')) |
| Input | rw_flg | Boolean [Y/N] parameter to set the connection access to readonly or with write access by removing the "access=readonly" part from the DBOPTS string. The default value is: N. |
| Input | sendmail | Boolean [Y/N] parameter to specify if in case of problems a mail is to be sent to a administrator. The default value is: N. |
| Input | mailaddr | Email address of a private person or mail group. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* None

### Calls
* [m_log_set_options.sas](m_log_set_options.md)
* [m_sys_upd_dbaccess.sas](m_sys_upd_dbaccess.md)
* [m_utl_dec_passwd.sas](m_utl_dec_passwd.md)
* [m_utl_get_userid.sas](m_utl_get_userid.md)
* [m_utl_mail_notification.sas](m_utl_mail_notification.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_quote_elems.sas](m_utl_quote_elems.md)
* [m_utl_unique_number.sas](m_utl_unique_number.md)

### Usage

##### Example 1: Show help information:
```sas
%m_sys_set_dbaccess(?)
```

##### Example 2 - Step 1: Create new DBACCESS table:
```sas
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , mode    = C
   );
```

##### Example 2 - Step 2: Insert a new entry with access readonly:
```sas
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , dnam    = TEMP
 , dtyp    = SAS
 , dpth    = %str(%sysfunc(getoption(WORK)))
 , dacc    = T
 , dopt    = %str(access=readonly)
 , mode    = I
   );
```

##### Example 2 - Step 3: View the newly made DBACCESS entry:
```sas
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , dsel    = %str(dbname='TEMP')
 , mode    = V
   );
```

##### Example 2 - Step 4: Set the new entry with write access:
```sas
%m_sys_set_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , list    = %quote(TEMP)
 , rw_flg  = Y
 , debug   = N
   );
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
*This document was generated on 26.09.2023 at 15:39:58  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
