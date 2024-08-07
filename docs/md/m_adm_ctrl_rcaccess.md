![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_adm_ctrl_rcaccess.sas

### Admin

##### Admin macro to administrate access to remote connect servers.

***

### Description
Macro to administrate the SAS remote connect server entries in the rcaccess table. An admin can use this macro to initially create the rcaccess table, insert, update, delete entries or view all entries into a report which can be send to a given email address. The program contains a SAS print routine to display the pre- and post states of the rcaccess record entry change action.



##### *Note:*
*The SAS dataset containing the database connection profiles has to be named rcaccess since all the routines expects this.*
*If you lose or forget the ENCRYPTKEY, there will be absolutely no way to open the rcaccess table and recover the data!*

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
| Input | rctable | Full qualified LIBNAME.rcaccess table name. |
| Input | rckey | Value of the ENCRYPTKEY parameter. The minimum string length needs to be 8 characters long. |
| Input | rname | Mandatory. Remote connection name. The maximum length is 10 characters. |
| Input | rdest | Mandatory. Destination name of the remote host connection. The maximum length is 15 characters. |
| Input | renv | Indicator [DEV/UAT/PRD] environment code of the remote host connection. |
| Input | rhost | Mandatory. Server address and port to establish a a remote connection. The host and port value are separated by a blank character. (For example: mydomain.com 7551) |
| Input | racc | Mandatory. Indicator [P/T] for the entry access mode user type (RUSR) which can be (P)ersonal or (T)echnical. The default value is: T (technical). |
| Input | lusr | Optional. Local user initiating the remote server connection. |
| Input | rusr | Optional. User name for establishing the remote server connection. |
| Input | rpwd | Optional. Remote connection access password. |
| Input | ract | Boolean [Y/N] flag to indicate that an entry is to be set to active or inactive. |
| Input | rsel | Optional. Contains a where statement to select the entries from the rcaccess table by either RCNAME, RCDEST, RCENV, RCHOST, RCACCS, LUSER or ACTIVE. This parameter is only valid in combination with MODE parameter value equal to V (view entries). |
| Input | mode | Indicator [C/D/I/U/V] to define the table update mode: (C)reate, (D)elete, (I)nsert, (U)pdate or (V)iew for viewing the table content. The Default value is V. |
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
%m_adm_ctrl_rcaccess(?)
```

##### Example 2: Create new RCACCESS table (Mode=C):
```sas
%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , mode    = C
 , print   = Y
 , debug   = Y
   );
```

##### Example 3: Insert a new Remote Connection entry (Mode=I and access: technical):
```sas
%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rname   = HMSDEV
 , rdest   = HERMES
 , renv    = DEV
 , rhost   = %str(hermes.local 7551)
 , racc    = T
 , rusr    = dummy
 , rpwd    = XXX
 , mode    = I
 , print   = Y
 , debug   = Y
   );
```

##### Example 4: Insert a new Remote Connection entry (Mode=I and access: personal):
```sas
%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rname   = HMSDEV
 , rdest   = HERMES
 , renv    = DEV
 , rhost   = %str(hermes.local 7551)
 , racc    = P
 , lusr    = sasdemo
 , rusr    = sasdemo
 , rpwd    = XXX
 , mode    = I
 , print   = Y
 , debug   = Y
   );
```

##### Example 5: View the technical Remote Connection entry for HMSDEV (Mode=V):
```sas
%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rsel    = %str(rcname='HMSDEV' and rcaccs='T')
 , mode    = V
 , print   = Y
 , debug   = Y
   );
```

##### Example 6: Send the complete Remote Connection entry list by mail (Mode=V):
```sas
%m_adm_ctrl_rcaccess(
   rctable  = WORK.rcaccess
 , rckey    = aespasskey
 , mode     = V
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
 , debug    = Y
   );
```

##### Example 7: Deactivate a Remote Connection entry (Mode=U and access: technical):
```sas
%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rname   = HMSDEV
 , ract    = N
 , mode    = U
 , print   = Y
 , debug   = N
   );
```

##### Example 8: View the current Remote Connection entry list (Mode=V):
```sas
%m_adm_ctrl_rcaccess(
   rctable  = WORK.rcaccess
 , rckey    = aespasskey
 , mode     = V
 , print    = Y
 , debug    = Y
   );

```

##### Example 9: Delete a Remote Connection entry (Mode=D and access: technical):
```sas
%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rname   = HMSDEV
 , racc    = T
 , mode    = D
 , print   = Y
 , debug   = N
   );
```

##### Example 10: View the current Remote Connection entry list (Mode=V):
```sas
%m_adm_ctrl_rcaccess(
   rctable  = WORK.rcaccess
 , rckey    = aespasskey
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
*This document was generated on 2020.09.07 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
