# File Reference: m_adm_ctrl_mdaccess.sas

### Admin

##### Admin macro to administrate access to SAS metadata servers.

***

### Description
Macro to administrate the SAS metadata server connection entries in the mdaccess table. An admin can use this macro to initially create the mdaccess table, insert, update, delete entries or view all entries into a report which can be send to a given email address. The program contains a SAS print routine to display the pre- and post states of the mdaccess record entry change action.

##### *Note:*
*The SAS dataset containing the database connection profiles has to be named MDACCESS since all the routines expects this.*
*If you lose or forget the ENCRYPTKEY, there will be absolutely no way to open the MDACCESS table and recover the data!*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-09-26 00:00:00

### Version
* 20.1.09

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | mdtable | Full qualified LIBNAME.mdaccess table name. |
| Input | mdkey | Value of the ENCRYPTKEY parameter. The minimum string length needs to be 8 characters long. |
| Input | mname | Mandatory. SAS metadata server connection name. The maximum length is 10 characters. |
| Input | menv | Indicator [DEV/UAT/PRD] environment code of the SAS metadata server connection. |
| Input | mhost | Mandatory. Server address name to establish a SAS metadata server connection. |
| Input | mport | Mandatory. Server port number to establish a SAS metadata server connection. |
| Input | macc | Mandatory. Indicator [P/T] for the entry access mode user type (RUSR) which can be (P)ersonal or (T)echnical. The default value is: T (technical). |
| Input | lusr | Optional. Local user initiating the connection. |
| Input | musr | Optional. User name for establishing the SAS metadata server connection. |
| Input | mpwd | Optional. SAS metadata server connection password. |
| Input | mact | Boolean [Y/N] flag to indicate that an entry is to be set to active or inactive. |
| Input | msel | Optional. Contains a where statement to select the entries from the mdaccess table by either MDNAME, MDENV, MDHOST, MDACCS, LUSER or ACTIVE. This parameter is only valid in combination with MODE parameter value equal to V (view entries). |
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
%m_adm_ctrl_mdaccess(?)
```

##### Example 2: Create new MDACCESS table (Mode=C):
```sas
%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mode    = C
 , print   = Y
 , debug   = Y
   );
```

##### Example 3: Insert a new SAS Metadata server connection entry (Mode=I and access: technical):
```sas
%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mname   = HMSDEV
 , menv    = DEV
 , mhost   = %str(hermes.local)
 , mport   = 8561
 , macc    = T
 , musr    = dummy
 , mpwd    = XXX
 , mode    = I
 , print   = Y
 , debug   = Y
   );
```

##### Example 4: Insert a new SAS Metadata server connection entry (Mode=I and access: personal):
```sas
%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mname   = HMSDEV
 , menv    = DEV
 , mhost   = %str(hermes.local)
 , mport   = 8561
 , macc    = P
 , lusr    = sasdemo
 , musr    = sasdemo
 , mpwd    = XXX
 , mode    = I
 , print   = Y
 , debug   = Y
   );
```

##### Example 5: View the technical SAS Metadata server connection entry for HMSDEV (Mode=V):
```sas
%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , msel    = %str(mdname='HMSDEV' and mdaccs='T')
 , mode    = V
 , print   = Y
 , debug   = Y
   );
```

##### Example 6: Send the complete SAS Metadata server connection entry list by mail (Mode=V):
```sas
%m_adm_ctrl_mdaccess(
   mdtable  = WORK.mdaccess
 , mdkey    = aespasskey
 , mode     = V
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
 , debug    = Y
   );
```

##### Example 7: Deactivate a SAS Metadata server connection entry (Mode=U and access: technical):
```sas
%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mname   = HMSDEV
 , mact    = N
 , mode    = U
 , print   = Y
 , debug   = N
   );
```

##### Example 8: View the current SAS Metadata server connection entry list (Mode=V):
```sas
%m_adm_ctrl_mdaccess(
   mdtable  = WORK.mdaccess
 , mdkey    = aespasskey
 , mode     = V
 , print    = Y
 , debug    = Y
   );

```

##### Example 9: Delete a SAS Metadata server connection entry (Mode=D and access: technical):
```sas
%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mname   = HMSDEV
 , macc    = T
 , mode    = D
 , print   = Y
 , debug   = N
   );
```

##### Example 10: View the current SAS Metadata server connection entry list (Mode=V):
```sas
%m_adm_ctrl_mdaccess(
   mdtable  = WORK.mdaccess
 , mdkey    = aespasskey
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
*This document was generated on 30.10.2022 at 09:11:36  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
