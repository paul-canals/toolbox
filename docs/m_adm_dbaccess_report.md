# File Reference: m_adm_dbaccess_report.sas

### Admin

##### Admin macro to create the database connections list report.

***

### Description
The macro creates a report of all database connections and SAS librefs using the database groups known on the SAS Metadata Server filtered by by PREFIX= and DBSVAL=, against the entries listed in the DBACCESS table. The result information is presented by a SAS proc report step and can be send by email as an PDF format attachment.

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-09-08 00:00:00

### Version
* 20.1.09

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | dstable | Full name of the DBACCESS table <LIBNAME.TABLENAME>. |
| Input | dskey | Value of the ENCRYPTKEY parameter. The minimum string length is 8 characters long. If you lose or forget the ENCRYPTKEY, there will be absolutely no way to open the DBACCESS table and recover the data. |
| Input | prefix | Mandatory. Textual string to filter on the IDENTITY GROUP within the SAS metadata. |
| Input | dbsval | Mandatory. Is used to filter the group membership to search for relevant database connections. |
| Input | print | Boolean [Y/N] parameter to decide wether output is generated using a proc print or report step. The default value for PRINT is: N. |
| Input | sendmail | Boolean [Y/N] parameter to decide if the result information list is to be send to email address. The default value is: N. |
| Input | mailaddr | Send to email address of private person or group. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* WORK.DBCONNECT.

### Calls
* [m_log_set_options.sas](m_log_set_options.md)
* [m_sys_get_dbaccess.sas](m_sys_get_dbaccess.md)
* [m_utl_dec_passwd.sas](m_utl_dec_passwd.md)
* [m_utl_delete_file.sas](m_utl_delete_file.md)
* [m_utl_mail_notification.sas](m_utl_mail_notification.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_printto.sas](m_utl_printto.md)
* [m_utl_unique_number.sas](m_utl_unique_number.md)

### Usage

##### Example 1: Show help information:
```sas
%m_adm_dbaccess_report(?)
```

##### Example 2: Output report to result tab:
```sas
%m_adm_dbaccess_report(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , prefix  = PRC
 , dbsval  = DBS
 , print   = Y
 , debug   = N
   );
```

##### Example 3: Output report in PDF by email:
```sas
%m_adm_dbaccess_report(
   dstable  = WORK.dbaccess
 , dskey    = aespasskey
 , prefix   = PRC
 , dbsval   = DBS
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
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
*This document was generated on 27.09.2021 at 15:27:44  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
