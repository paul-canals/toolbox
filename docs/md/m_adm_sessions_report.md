![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_adm_sessions_report.sas

### Admin

##### Admin macro to create a current user sessions list report.

***

### Description
The macro creates a list report of all current active user sessions and possible ghost processes on the SAS Server. The result information is presented by a SAS proc report step and can be send by email as an PDF format attachment.

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
| Input | host | Full qualified  name (DNS Name). |
| Input | port | SAS Object Spawner  number. |
| Input | user | User name, with administrator access. |
| Input | pass | User corresponding password. |
| Input | print | Boolean [Y/N] parameter to generate the output by a proc report step with style HtmlBlue. The default value is: N. |
| Input | sendmail | Boolean [Y/N] parameter to decide if the result information list is to be send to email address. The default value is: N. |
| Input | mailaddr | Send to email address of private person or group. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* A list of all current SAS user sessions

### Calls
* [m_utl_delete_file.sas](m_utl_delete_file.md)
* [m_utl_mail_notification.sas](m_utl_mail_notification.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_printto.sas](m_utl_printto.md)

### Usage

##### Example 1: Show help information:
```sas
%m_adm_sessions_report(?)
```

##### Example 2: Output report to result:
```sas
%m_adm_sessions_report(
   host  = hermes.pact.SAS.com
 , port  = 8581
 , user  = sasadm@saspw
 , pass  = {SAS002}DA9A0A5C1A1935335ABF908E1DAAB71E
 , print = Y
   );
```

##### Example 3: Output report by email:
```sas
%m_adm_sessions_report(
   host     = hermes.pact.SAS.com
 , port     = 8581
 , user     = sasadm@saspw
 , pass     = {SAS002}DA9A0A5C1A1935335ABF908E1DAAB71E
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
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
*This document was generated on 12.02.2024 at 06:35:35  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v23.1.10)*
