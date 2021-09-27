# File Reference: m_adm_migrate_data.sas

### Admin

##### Admin macro to migrate datasets and views to another system.

***

### Description
This program can be used to migrate SAS datasets and SAS views from one system and encoding to another system with a different encoding. The migration of SAS datasets uses the XPT transport file mechanism for exporting source system and importing on the target system. For the SAS view migration the view description information is exported over a XPT transport file, and is used to recreate the SAS view on the target system. The result information is presented by a SAS proc report step and can be send by email as an PDF format attachment.

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
| Input | src_path | Specifies the full path for the source files. The default value for SRC_PATH is: \_NONE\_. |
| Input | src_enc | Optional. Specifies the system encoding value for the source file reference. |
| Input | trg_path | Specifies the full path for the target files. The default value for TRG_PATH is: \_NONE\_. |
| Input | trg_enc | Optional. Specifies the system encoding value for the target file reference. |
| Input | xpt_fmt | Indicator [V5/V8/V9/AUTO] parameter to specify the format of the transport file. Valid values are: V5 (for V5 transport), V8 (for V8 extended transport), V9 (for V9 extended transport) or AUTO (format is determined by BASE_DS data). The default value for FORMAT is: AUTO. |
| Input | mode | Indicator [FULL/I/E/V] parameter to specify the macro execution mode. If set to FULL, the files are exported from a given source path, and then imported into a given target path. If set to I, the macro only imports (already exported) files in XPT/DDL format from a given root source path. It expects the XPT files in a subdirectory from the given source root path with the name 'xpt', and also expects the dataset DDL files in a subdirectory from the given source root path with the name 'ddl'. Furthermore it expects the XPT filename to contain a prefix DS_ for data sets, and VW_ for SQL or Data Step views. If set to E, the macro only exports files from the given source path to the given target path. The sub directories 'ddl' and 'xpt' are created automatically in the target path, and contains the exported datasets and views. If set to V, the macro validates the target members TRG_PATH against the source members SRC_PATH and returns a report or a table containing comparison info. The default value for MODE is: FULL. |
| Input | type | Indicator [ALL/DS/VW] parameter to specify the file types to be selected from the source path and migrated to the target path. If set to ALL, all types will be selected. If set to DS, only SAS data sets will be migrated. If set to VW, only SQL or Data Step views will be migrated. The default value for TYPE is: ALL. |
| Input | subdirs | Boolean [Y/N] parameter to specify if the list should include files in sub-directories under the given source and target paths. The default value for SUBDIRS is: N. |
| Input | finfo | Boolean [Y/N] parameter to specify additional information to be included to the source and target file list. This information includes the size of the file, the creation timestamp, and, the last modification timestamp values. The default value for FINFO is: N. |
| Input | cvpmult | Indicator [1..4] to specify the CVP multiplier value for the CVP library engine. The value is used when the target encoding is set to UTF-8. The default value for CVPMULT is: 2. |
| Input | print | Boolean [Y/N] parameter to generate the output by a proc report step with style HtmlBlue. The default value is: N. |
| Input | sendmail | Boolean [Y/N] parameter to decide if the result information list is to be send to email address. The default value is: N. |
| Input | mailaddr | Send to email address of private person or group. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Migrated source files on the target path.

### Calls
* [m_log_set_options.sas](m_log_set_options.md)
* [m_utl_create_dir.sas](m_utl_create_dir.md)
* [m_utl_ddl2ds.sas](m_utl_ddl2ds.md)
* [m_utl_ds2ddl.sas](m_utl_ds2ddl.md)
* [m_utl_ds2xpt.sas](m_utl_ds2xpt.md)
* [m_utl_get_file_list.sas](m_utl_get_file_list.md)
* [m_utl_hash_lookup.sas](m_utl_hash_lookup.md)
* [m_utl_mail_notification.sas](m_utl_mail_notification.md)
* [m_utl_nlobs.sas](m_utl_nlobs.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_printto.sas](m_utl_printto.md)
* [m_utl_unique_number.sas](m_utl_unique_number.md)
* [m_utl_vw2xpt.sas](m_utl_vw2xpt.md)
* [m_utl_xpt2ds.sas](m_utl_xpt2ds.md)
* [m_utl_xpt2vw.sas](m_utl_xpt2vw.md)

### Usage

##### Example 1: Show help information:
```sas
%m_adm_migrate_data(?)
```

##### Example 2: Migrate data from SASHELP to WORK (Mode=Full):
```sas
%m_adm_migrate_data(
   src_path = %str(%sysget(SASROOT)/core/sashelp)
 , trg_path = %str(%sysfunc(getoption(WORK))/sashelp)
 , print    = Y
 , debug    = N
   );
```

##### Example 3: Migrate data from SASHELP to WORK (Mode=Full):
```sas
%m_adm_migrate_data(
   src_path = %str(%sysget(SASROOT)/core/sashelp)
 , trg_path = %str(%sysfunc(getoption(WORK))/sashelp)
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
 , debug    = N
   );
```

##### Example 4: Export SAS datasets from CORE recursively (Mode=Export):
```sas
%m_adm_migrate_data(
   src_path = %str(%sysget(SASROOT)/core)
 , trg_path = %str(%sysfunc(getoption(WORK))/export)
 , mode     = E
 , type     = ALL
 , subdirs  = Y
 , finfo    = Y
 , print    = Y
 , debug    = N
   );
```

##### Example 5: Import SAS datasets to CORE recursively (Mode=Import):
```sas
%m_adm_migrate_data(
   src_path = %str(%sysfunc(getoption(WORK))/export)
 , trg_path = %str(%sysfunc(getoption(WORK))/core)
 , mode     = I
 , type     = DS
 , subdirs  = Y
 , finfo    = Y
 , print    = Y
 , debug    = N
   );
```

##### Example 6: Import SAS views to CORE recursively (Mode=Import):
```sas
%m_adm_migrate_data(
   src_path = %str(%sysfunc(getoption(WORK))/export)
 , trg_path = %str(%sysfunc(getoption(WORK))/core)
 , mode     = I
 , type     = VW
 , subdirs  = Y
 , finfo    = Y
 , print    = Y
 , debug    = N
   );
```

##### Example 7: Validate core source against target (Mode=Validate):
```sas
%m_adm_migrate_data(
   src_path = %str(%sysget(SASROOT)/core)
 , trg_path = %str(%sysfunc(getoption(WORK))/core)
 , mode     = V
 , type     = ALL
 , subdirs  = Y
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
*This document was generated on 27.09.2021 at 15:27:48  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
