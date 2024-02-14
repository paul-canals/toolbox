![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_sys_get_meta_info.sas

### System

##### System macro to control the SAS user environment setup at logon.

***

### Description
This program controls the SAS user environment by reading the group memberships from metadata, the database library information from the DBACCESS table and sets global macro variables based on the users function and role. The macro is called by the appserver_autoexec_usermods.sas at logon and creates result control datasets in the USR_INFO library containing information on the users metadata and his personal database access list.

##### *Note:*
*The user groups within the SAS Metadata Server needs to be named according to the following naming convention: User group within RACE : GRP_SYS_* (e.g.\ GRP_SYS_IT_DEVELOPER) Database access control : GRP_DBS_* (e.g.\ GRP_DBS_ACCESS_SAP_BW)*

##### *Warning:*
*Do remember that a user can only be a member of just one main user group in SAS Metadata representing his role!*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-10-06 00:00:00

### Version
* 23.1.10

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | audit | Mandatory. The full path to the sessions folder. The default value is: &APPL_BASE./audit. |
| Input | userid | Mandatory. The user's Identifier. (eg SYSUSERID). |
| Input | prefix | Mandatory. Textual string to filter on the IDENTITY GROUP within the SAS metadata. The default value is: GRP. |
| Input | prjlist | Optional. If omitted, all group memberships will be selected and returned as result. If set, only valid project ID's should be entered to filter the result. The default value is: SYS. |
| Input | dbsval | Mandatory. Is used to filter the group membership to search for relevant database connections. The default value is: DBS. |
| Input | outlib | Libref name in which the META_INFO and PROJ_INFO datasets will be created into. The default value is: WORK. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* WORK._PROJ_INFO

### Returns
* WORK._PROJ_INFO

### Returns
* WORK._PROJ_INFO

### Returns
* WORK._PROJ_INFO

### Returns
* WORK._PROJ_INFO

### Calls
* [m_utl_clr_table_lock.sas](m_utl_clr_table_lock.md)
* [m_utl_create_dir.sas](m_utl_create_dir.md)
* [m_utl_get_curdir.sas](m_utl_get_curdir.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_set_table_lock.sas](m_utl_set_table_lock.md)

### Usage

##### Example 1: Show help information:
```sas
%m_sys_get_meta_info(?)
```

##### Example 2: Retrieve metadata information for current user:
```sas
%m_sys_get_meta_info(
   audit  = %sysfunc(getoption(WORK))/audit
 , userid = &sysuserid.
 , prefix = GRP
 , prjlst = %quote('CRM','MRM','SYS')
 , dbsval = DBS
 , outlib = WORK
 , debug  = N
   );
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
*This document was generated on 2023.10.06 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
