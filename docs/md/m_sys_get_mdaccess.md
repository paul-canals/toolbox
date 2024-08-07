![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_sys_get_mdaccess.sas

### System

##### System macro to get admin user credentials for metadata access.

***

### Description
This macro is used for retrieving user credentials for an admin user to access SAS metadata server.

 The SAS dataset containing the database connection profiles has to be named MDACCESS since all the routines expects this.



##### *Note:*
*If you lose or forget the ENCRYPTKEY, there will be absolutely no way to open the MDACCESS table and recover the data!*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-08-03 00:00:00

### Version
* 24.1.08

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | mdtable | Full qualified table name <LIBNAME.dbaccess>. |
| Input | mdkey | Value of the ENCRYPTKEY parameter. The minimum string length needs to be 8 characters long. |
| Input | mname | Optional. SAS metadata server connection name. Please note that if this parameter is set, the MNAME value must relate to an unique entry in the MDACCESS table, otherwise the SAS metadata server information may not be correct. |
| Input | menv | Optional. Indicator [DEV/UAT/PRD] environment code of the SAS metadata server connection. |
| Input | macc | Mandatory. Indicator [P/T] for the entry access mode user type (MDUSR) which can be (P)ersonal or (T)echnical. The default value is T (technical). |
| Input | lusr | Optional. Local user initiating the SAS metadata server connection. |
| Input | host | Optional. Alias of the MENV parameter. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Admin user access credentials for a SAS metadata server

### Calls
* [m_utl_dec_passwd.sas](m_utl_dec_passwd.md)
* [m_utl_get_userid.sas](m_utl_get_userid.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_sys_get_mdaccess(?)
```

##### Prepare a MDACCESS table for the next examples:
```sas
%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mode    = C
 , print   = Y
 , debug   = N
   );

%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mname   = HMSDEV
 , menv    = DEV
 , mhost   = %str(dev.hermes.local)
 , mport   = 8561
 , macc    = T
 , musr    = dummy
 , mpwd    = XXX
 , mode    = I
 , print   = Y
 , debug   = N
   );

%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mname   = HMSDEV
 , menv    = DEV
 , mhost   = %sysfunc(getoption(METASERVER))
 , mport   = %sysfunc(getoption(METAPORT))
 , macc    = P
 , lusr    = &sysuserid.
 , musr    = &sysuserid.
 , mpwd    = %str(P@ul1970)
 , mode    = I
 , print   = Y
 , debug   = N
   );

%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mname   = HMSUAT
 , menv    = UAT
 , mhost   = %str(uat.hermes.local)
 , mport   = 8561
 , macc    = T
 , musr    = dummy
 , mpwd    = XXX
 , mode    = I
 , print   = Y
 , debug   = N
   );

%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mode    = V
 , print   = Y
 , debug   = N
   );
```

##### Example 2: Get metadata server connection information for a technical user (MENV=):
```sas
%m_sys_get_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , menv    = DEV
 , debug   = Y
   );

proc options group=meta short;
run;
```

##### Example 3: Get metadata server connection information for a technical user (MNAME=):
```sas
%m_sys_get_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mname   = HMSDEV
 , debug   = N
   );

proc options group=meta short;
run;
```

##### Example 4: Get metadata server connection information for a personal user (MENV=):
```sas
%m_sys_get_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , menv    = DEV
 , macc    = P
 , lusr    = &sysuserid.
 , debug   = Y
   );

proc options group=meta short;
run;
```

##### Example 5: Get metadata server connection information for a personal user (MNAME=):
```sas
%m_sys_get_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mname   = HMSDEV
 , macc    = P
 , lusr    = &sysuserid.
 , debug   = N
   );

proc options group=meta short;
run;
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
*This document was generated on 2024.08.03 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
