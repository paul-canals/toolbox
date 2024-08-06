![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_sys_get_dbaccess.sas

### System

##### System macro to get a user, password, path information string.

***

### Description
This macro is used for retrieving an inline database connection access string so that it can be used in a database passthrough execution statement. The macro currently works for the following database management system type connections:

- DB2 : IBM DB-2
- ORA : Oracle
- PGS : PostgreSQL

 The SAS dataset containing the database connection profiles has to be named DBACCESS since all the routines expects this.



##### *Note:*
*If you lose or forget the ENCRYPTKEY, there will be absolutely no way to open the DBACCESS table and recover the data!*

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
| Input | dstable | Full qualified table name <LIBNAME.dbaccess>. |
| Input | dskey | Value of the ENCRYPTKEY parameter. The minimum string length needs to be 8 characters long. |
| Input | dbname | Name of the database connection or SAS libref. The maximum length is 8 characters. |
| Input | dbtype | Database management type [DB2/ORA/PGS] The default value for DBTYPE is: ORA. |
| Input | dbaccs | Access mode [P/T]; indicator to define the access type which can be (P)ersonal or (T)echnical. The default value for DBACCS is: T. |
| Input | schema | Boolean [Y/N] flag to indicate that the _SCHEMA=_ is to be included in the return string. |
| Input | dbopts | Boolean [Y/N] flag to indicate that the connection options are to be included in the return string. |
| Input | rw_flg | Boolean [Y/N] flag to indicate that the connection string includes access to readonly or write access. The default value fro RW_FLG is: N. |
| Input | sec_flg | Boolean [Y/N] flag to indicate wether the security routine is to be activated to check if the user is allowed to get the return string. The routine checkes the session user id value against the user name value for the dbaccess entry. The default value for SEC_FLG is: Y. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |
| Output | result | The returned value string containing the database connection information for inline macro processing. |

### Returns
* Access information for a given database connection.

### Calls
* [m_utl_dec_passwd.sas](m_utl_dec_passwd.md)
* [m_utl_get_userid.sas](m_utl_get_userid.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_sys_get_dbaccess(?)
```

##### Example 2 - Step 1: Create a new DBACCESS table:
```sas
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , mode    = C
   );
```

##### Example 2 - Step 2: Insert a new Database entry:
```sas
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , dnam    = TEST
 , dtyp    = ORA
 , dusr    = orademo
 , dpwd    = ORApw123
 , dpth    = XE
 , dsch    = pact
 , dopt    = %str(ACCESS=READONLY)
 , dacc    = T
 , mode    = I
   );
```

##### Example 2 - Step 3: Retrieve Database entry string:
```sas
%let string =
   %m_sys_get_dbaccess(
      dstable = WORK.dbaccess
    , dskey   = aespasskey
    , dbname  = TEST
    , dbtype  = ORA
    , dbaccs  = T
    , schema  = N
    , rw_flg  = Y
      );

%m_utl_print_message(
   program = M_SYS_GET_DBACCESS
 , status  = OK
 , message = %quote(&string.)
 , print   = Y
 , debug   = N
   );
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
