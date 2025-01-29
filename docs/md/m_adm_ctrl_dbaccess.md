[![../../misc/images/doc_header.png](../../misc/images/doc_header.png)](#)
# 
# File Reference: m_adm_ctrl_dbaccess.sas

### Admin

##### Admin macro to administrate access to DBMS and SAS librefs.

***

### Description
Macro to administrate the database connection entries in the DBACCESS table. An admin uses this macro to initially create the DBACCESS table, insert, update, delete entries or view all entries in a report which can be send to an email address. The program contains a SAS print routine to display the pre and post states of the DBACCESS record entry change action.



##### *Note:*
*The SAS dataset containing the database connection profiles has to be named DBACCESS since all the routines expects this.*
*If you lose or forget the ENCRYPTKEY, there will be absolutely no way to open the DBACCESS table and recover the data!*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-10-27 00:00:00

### Version
* 20.1.10

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | dstable | Full qualified LIBNAME.dbaccess table name. |
| Input | dskey | Value of the ENCRYPTKEY parameter. The minimum string length needs to be 8 characters long. |
| Input | dnam | Name of the database connection or SAS libref. The maximum length is 8 characters. |
| Input | dtyp | Mandatory. Indicator [DB2/ODBC/ORA/PGS/SAP/SAS] for dbms type selection. The default value is SAS. |
| Input | dpth | Optional. Database instance name or path. |
| Input | dsch | Optional. Database schema name. |
| Input | dusr | Optional. Database access user name. |
| Input | dpwd | Optional. Database access password. |
| Input | dacc | Mandatory. Indicator [P/T] for the entry access mode user type (DUSR) which can be (P)ersonal or (T)echnical. This parameter must always be set, even if the database type (DTYP) is set to SAS. The default value is: T (technical). |
| Input | dpck | Optional. Specifies an unique package name to combine multiple DNAM database connection names into one group. The m_sys_set_dbaccess.sas can be called using the package name as the value for the LIST argument parameter instead of the default database connection name or SAS libref. |
| Input | dopt | Optional. DBMS options separated by using a blank. |
| Input | dact | Boolean [Y/N] flag to indicate that an entry is to be set to active or inactive. |
| Input | iflg | Boolean [Y/N] flag to specify if an entry is to be included in the (user) connection list. |
| Input | dsel | Optional. Contains a where statement to select the entries from the DBACCESS table by either DBNAME, DBTYPE, DBUSER or ACTIVE. This parameter is only valid in combination with MODE parameter value equal to V (view entries). |
| Input | mode | Indicator [C/D/I/U/V] to define the table update mode: (C)reate, (D)elete, (I)nsert, (U)pdate or (V)iew for viewing the table content. The Default value is: V. |
| Input | print | Boolean [Y/N] parameter to decide wether output is generated using a proc print or report step. The default value for PRINT is: N. |
| Input | sendmail | Boolean [Y/N] parameter to decide if the result information list is to be send to email address. The default value is: N. |
| Input | mailaddr | Send to email address of private person or group. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* WORK.REPORT

### Calls
* [m_utl_create_dir.sas](m_utl_create_dir.md)
* [m_utl_dec_passwd.sas](m_utl_dec_passwd.md)
* [m_utl_enc_passwd.sas](m_utl_enc_passwd.md)
* [m_utl_mail_notification.sas](m_utl_mail_notification.md)
* [m_utl_nlobs.sas](m_utl_nlobs.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_adm_ctrl_dbaccess(?)
```

##### Example 2: Create new DBACCESS table (Mode=C):
```sas
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , mode    = C
 , print   = Y
   );
```

##### Example 3: Insert a new Database entry (Mode=I):
```sas
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , dnam    = TEMP
 , dtyp    = SAS
 , dpth    = %str(%sysfunc(getoption(WORK))/archived)
 , dacc    = T
 , mode    = I
 , print   = Y
   );
```

##### Example 4: Update the new entry options (Mode=U):
```sas
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , dnam    = TEMP
 , dtyp    = SAS
 , dopt    = %str(access=readonly)
 , mode    = U
 , print   = Y
   );
```

##### Example 5: View the DBACCESS entries (Mode=V):
```sas
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , dsel    = %str(dbname="TEMP")
 , mode    = V
 , print   = Y
   );
```

##### Example 6: Send the entry list by mail (Mode=V):
```sas
%m_adm_ctrl_dbaccess(
   dstable  = WORK.dbaccess
 , dskey    = aespasskey
 , mode     = V
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
   );
```

##### Example 7 Deactivate a Database entry (Mode=U):
```sas
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , dnam    = TEMP
 , dtyp    = SAS
 , dact    = N
 , mode    = U
 , print   = Y
   );
```

##### Example 8: View the current Database entry list (Mode=V):
```sas
%m_adm_ctrl_dbaccess(
   dstable  = WORK.dbaccess
 , dskey    = aespasskey
 , mode     = V
 , print    = Y
 , debug    = Y
   );

```

##### Example 9: Delete a Database entry (Mode=D):
```sas
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , dnam    = TEMP
 , dtyp    = SAS
 , mode    = D
 , print   = Y
   );
```

##### Example 10: View the current Database entry list (Mode=V):
```sas
%m_adm_ctrl_dbaccess(
   dstable  = WORK.dbaccess
 , dskey    = aespasskey
 , mode     = V
 , print    = Y
 , debug    = N
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
*This document was generated on 2020.10.27 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
