![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_sys_get_rcaccess.sas

### System

##### System macro to retrieve a remote connection information string.

***

### Description
This macro is used for retrieving remote connection profile information stored in the RCACCESS table to be able to connect to a SAS connect server by using a remote submit statement.

##### *Note:*
*The SAS dataset containing the database connection profiles has to be named RCACCESS since all the routines expects this.*
*If you lose or forget the ENCRYPTKEY, there will be absolutely no way to open the RCACCESS table and recover the data!*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-12-07 00:00:00

### Version
* 20.1.12

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | rctable | Full qualified LIBNAME.rcaccess table name. |
| Input | rckey | Value of the ENCRYPTKEY parameter. The minimum string length needs to be 8 characters long. |
| Input | rname | Optional. Remote connection name. Please note that if this parameter is set, the RNAME value must relate to an unique entry in the RCACCESS table, otherwise the remote host information may not be correct. |
| Input | rdest | Optional. Destination name of the remote connection. The maximum length is 15 characters. |
| Input | renv | Optional. Indicator [DEV/UAT/PRD] environment code of the remote host connection. |
| Input | racc | Mandatory. Indicator [P/T] for the entry access mode user type (RCUSR) which can be (P)ersonal or (T)echnical. The default value is T (technical). |
| Input | lusr | Optional. Local user initiating the remote server connection. |
| Input | mvar_rhost | Name of the macro variable containing the remote host information. The default value is: HOST. |
| Input | mvar_creds | Name of the macro variable containing the remote host credentials. The default value is: TCPSEC. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Access information for a given remote server connection.

### Calls
* [m_utl_dec_passwd.sas](m_utl_dec_passwd.md)
* [m_utl_get_userid.sas](m_utl_get_userid.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_sys_get_rcaccess(?)
```

##### Prepare a RCACCESS table for the next examples:
```sas
%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , mode    = C
 , print   = Y
 , debug   = N
   );

%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rname   = HMSDEV
 , rdest   = HERMES
 , renv    = DEV
 , rhost   = %str(dev.hermes.local 7551)
 , racc    = T
 , rusr    = dummy
 , rpwd    = XXX
 , mode    = I
 , print   = Y
 , debug   = N
   );

%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rname   = HMSDEV
 , rdest   = HERMES
 , renv    = DEV
 , rhost   = %str(dev.hermes.local 7551)
 , racc    = P
 , lusr    = &sysuserid.
 , rusr    = &sysuserid.
 , rpwd    = XXX
 , mode    = I
 , print   = Y
 , debug   = N
   );

%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rname   = HMSUAT
 , rdest   = HERMES
 , renv    = UAT
 , rhost   = %str(uat.hermes.local 7551)
 , racc    = T
 , rusr    = dummy
 , rpwd    = XXX
 , mode    = I
 , print   = Y
 , debug   = N
   );

%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , mode    = V
 , print   = Y
 , debug   = N
   );
```

##### Example 2: Get remote host information for a technical user (RENV= and RDEST=):
```sas
%m_sys_get_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rdest   = HERMES
 , renv    = DEV
 , debug   = Y
   );

data WORK.result;
   host = "&host.";
   tcpsec = "&tcpsec.";
run;

proc print data=WORK.result noobs;
run;
```

##### Example 3: Get remote host information for a technical user (RNAME=):
```sas
%m_sys_get_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rname   = HMSDEV
 , debug   = N
   );

data WORK.result;
   host = "&host.";
   tcpsec = "&tcpsec.";
run;

proc print data=WORK.result noobs;
run;
```

##### Example 4: Get remote host information for a personal user (RENV= and RDEST=):
```sas
%m_sys_get_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rdest   = HERMES
 , renv    = DEV
 , racc    = P
 , lusr    = &sysuserid.
 , debug   = Y
   );

data WORK.result;
   host = "&host.";
   tcpsec = "&tcpsec.";
run;

proc print data=WORK.result noobs;
run;
```

##### Example 5: Get remote host information for a personal user (RNAME=):
```sas
%m_sys_get_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rname   = HMSDEV
 , racc    = P
 , lusr    = &sysuserid.
 , debug   = N
   );

data WORK.result;
   host = "&host.";
   tcpsec = "&tcpsec.";
run;

proc print data=WORK.result noobs;
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
*This document was generated on 26.09.2023 at 15:39:53  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
