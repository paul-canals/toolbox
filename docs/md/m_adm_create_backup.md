![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_adm_create_backup.sas

### Admin

##### Admin macro to backup file system data in to a ZIP-archive.

***

### Description
The macro creates a compressed backup file of filesystem data directory and file structure into a ZIP format. The program contains print routines to display the list of files that are included in the compressed file (zip).

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-09-26 00:00:00

### Version
* 23.1.09

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | src_path | Full path to the directory on the filesystem that is to be copied. |
| Input | tmp_path | Optional. Full path to the directory on the filesystem where the directory structure and files are to be copied to. Default is WORK. |
| Input | tgt_path | Full path to the directory on the filesystem where the compressed file is to be copied to. |
| Input | tgt_file | Name of the compressed archive file, excluding the file extention. |
| Input | add_dttm | Boolean [Y/N] parameter to specify wether to append a suffix to the TGT_FILE name containing a timestamp value (format: yyyymmdd_hh_mm_ss). The default value for ADD_DTTM is: N. |
| Input | new_file | Boolean [Y/N] parameter to specify wether to overwrite, or append to an existing archive. The default value for NEW_FILE is: Y. |
| Input | enc_key | Optional. The encryption key to decrypt and re-encrypt the copy file. |
| Input | sendmail | Boolean [Y/N] parameter to decide if the result information list is to be send to email address. The default value for SENDMAIL is: N. |
| Input | mailaddr | Send to email address of private person or group. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* WORK.TGT_FILE_LIST

### Returns
* WORK.TGT_FILE_LIST

### Returns
* WORK.TGT_FILE_LIST

### Returns
* WORK.TGT_FILE_LIST

### Returns
* WORK.TGT_FILE_LIST

### Calls
* [m_utl_copy_tree.sas](m_utl_copy_tree.md)
* [m_utl_create_dir.sas](m_utl_create_dir.md)
* [m_utl_create_zip.sas](m_utl_create_zip.md)
* [m_utl_delete_tree.sas](m_utl_delete_tree.md)
* [m_utl_mail_notification.sas](m_utl_mail_notification.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_adm_create_backup(?)
```

##### Example 2 - Step 1: Create a backup in sources.zip archive:
```sas
%m_adm_create_backup(
   src_path = &APPL_PRGM.
 , tgt_path = &APPL_BASE./backup
 , tgt_file = toolbox
 , debug    = N
   );
```

##### Example 2 - Step 2: Add to an existing backup archive:
```sas
%m_adm_create_backup(
   src_path  = &APPL_BASE./misc/scripts
 , tgt_path  = &APPL_BASE./backup
 , tgt_file  = toolbox
 , new_file  = N
 , debug     = N
   );
```

##### Example 3: Create a new backup and send it by email:
```sas
%m_adm_create_backup(
   src_path = &APPL_PRGM.
 , tgt_path = &APPL_BASE./backup
 , tgt_file = sasautos
 , add_dttm = Y
 , sendmail = N
 , mailaddr = %str(pact@hermes.local)
 , debug    = N
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
*This document was generated on 2023.09.26 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
