![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_adm_kill_user_session.sas

### Admin

##### Admin macro to kill a current SAS Spawner user session.

***

### Description
The macro stops a SAS spawned server process identified by the Universal Unique user session IDentifier (UUID).

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-07-27 00:00:00

### Version
* 23.1.07

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
| Input | uuid | Universal unique ID of the spawned process that is to be killed. See usage examples for further info on how to get the UUID. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* WORK.PROCESS

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_adm_kill_user_session(?)
```

##### Example 2 - Step 1: Get the actual list of running processes:
```sas
%m_adm_sessions_report(
   host  = hermes.pact.SAS.com
 , port  = 8581
 , user  = sasadm@saspw
 , pass  = {SAS002}DA9A0A5C1A1935335ABF908E1DAAB71E
 , print = N
   );
```

##### Example 2 - Step 2: Select the user session process to stop:
```sas
data WORK.processes;
   set WORK.allpids(obs=1);
   keep
      ProcessIDentifier
      ProcessOwner
      UniqueIdentifier
      ;
   call symputx('sessionid',UniqueIdentifier);
run;

```

##### Example 2 - Step 3: Stop the user session process:
```sas
*%m_adm_kill_user_session(
*   host = hermes.pact.SAS.com
* , port = 8581
* , user = sasadm@saspw
* , pass = {SAS002}DA9A0A5C1A1935335ABF908E1DAAB71E
* , uuid = &sessionid.
*   );
```

### Copyright
Copyright 2008-2023 Paul Alexander Canals y Trocha. 
 
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
*This document was generated on 12.02.2024 at 06:35:32  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v23.1.10)*
