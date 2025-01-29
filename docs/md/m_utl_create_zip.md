[![../../misc/images/doc_header.png](../../misc/images/doc_header.png)](#)
# 
# File Reference: m_utl_create_zip.sas

### Utilities

##### Utility macro to copy files and directory tree into a ZIP file.

***

### Description
This program copies all files from a given directory including sub directories preserving the directory structure or it copies a single selected file defined by the INDIR into a ZIP archive. The macro uses the ODS package function or a fileref to create the archive. The ODS package archiving is restricted to a single source file size maximum of 4GB. This means that if a file has an uncompressed size larger than 4 GB, an error is returned. The ZIP fileref function comes without this restriction and is available since SAS 9.4. However when archiving a large number of files the ZIP fileref function can be much slower than with using ODS package ZIP archiving function. Therefore the program has a third and default runmode that combines both ODS archiving and ZIP fileref to overcome both the ODS 4GB restriction and the ZIP fileref problem. The macro program also checks for locked files, which are excluded gracefully from the archiving routine.

 When archiving single files into a ZIP archive, it is best to use the FILEREF runmode. When used in combination with a given ZIPNAME, it is possible to add files into a given ZIP archive.

 The finfo option for Zip archive members is based on the blog article "Using FILENAME ZIP and FINFO to list the details in your ZIP files" by Chris Hemedinger (chris.hemedinger@sas.com).



##### *Note:*
*This program is able to work in system environments where x-command or unix pipes are not allowed or cannot be used.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-08-26 00:00:00

### Version
* 24.1.08

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | indir | Full qualified path to the source directory, or full path and file name to a single file. |
| Input | infile | Alias of the INDIR= parameter when selecting an input file instead of an input directory. |
| Input | outdir | Full qualified path to the target directory where the ZIP file is to be created. |
| Input | zipname | Name of the archive file to be created including the .ZIP extention. |
| Input | runmode | Indicator [A/F/O] specify whether the macro uses the (O)DS package function, the (F)ileref or the default (A)uto mode for which a combination of ODS archiving and Fileref is selected to create the archive. The default value is: AUTO. |
| Input | overwrite | Boolean [Y/N] parameter to specify wether to overwrite or appended to an existing archive. The default value is: Y. |
| Input | subdirs | Boolean [Y/N] parameter to decide if the file list is to include files in sub directories under ROOTDIR. The default value is: N. |
| Input | emptydirs | Boolean [Y/N] parameter to specify wether empty folders are included in the output zip file. This parameter is only valid when used together with RUNMODE set to Auto, SUBDIRS set to Y. The default value for EMPTYDIRS is: N. |
| Input | print | Boolean [Y/N] parameter to generate the output by a proc print step. The default value is Y. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* The program returns a ZIP archive

### Calls
* [m_utl_create_dir.sas](m_utl_create_dir.md)
* [m_utl_delete_file.sas](m_utl_delete_file.md)
* [m_utl_get_file_list.sas](m_utl_get_file_list.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_create_zip(?)
```

##### Example 2: Copy SAS core samples into a ZIP file using Auto mode:
```sas
%m_utl_create_zip(
   indir   = %sysget(SASROOT)/core/sample
 , outdir  = %sysfunc(getoption(WORK))/backup
 , zipname = &sysuserid._sasuser.zip
 , runmode = AUTO
 , print   = Y
 , debug   = Y
   );
```

##### Example 3: Copy SAS core samples into a ZIP file using ODS package:
```sas
%m_utl_create_zip(
   indir     = %sysget(SASROOT)/core/sample
 , outdir    = %sysfunc(getoption(WORK))/backup
 , zipname   = &sysuserid._sasuser.zip
 , runmode   = ODS
 , overwrite = Y
 , subdirs   = Y
 , print     = Y
 , debug     = Y
   );
```

##### Example 4: Copy SAS core samples into a ZIP file using ZIP fileref:
```sas
%m_utl_create_zip(
   indir     = %sysget(SASROOT)/core/sample
 , outdir    = %sysfunc(getoption(WORK))/backup
 , zipname   = &sysuserid._sasuser.zip
 , runmode   = FILEREF
 , overwrite = Y
 , subdirs   = Y
 , print     = Y
 , debug     = Y
   );
```

##### Example 5: Copy a single file into a ZIP archive using Auto mode:
```sas
%m_utl_create_zip(
   indir     = %sysget(SASROOT)/core/sashelp/class.sas7bdat
 , outdir    = %sysfunc(getoption(WORK))/backup
 , runmode   = AUTO
 , overwrite = Y
 , print     = Y
 , debug     = Y
   );
```

##### Example 6: Step 1 - Copy a first file into a new ZIP archive: ;
```sas
%m_utl_create_zip(
   infile    = %sysget(SASROOT)/core/sashelp/class.sas7bdat
 , outdir    = %sysfunc(getoption(WORK))/backup
 , zipname   = class.zip
 , runmode   = FILEREF
 , overwrite = Y
 , print     = Y
 , debug     = Y
   );
```

##### Example 6: Step 2 - Copy a second file into the ZIP archive: ;
```sas
%m_utl_create_zip(
   infile    = %sysget(SASROOT)/core/sashelp/class.sas7bdat
 , outdir    = %sysfunc(getoption(WORK))/backup
 , zipname   = class.zip
 , runmode   = FILEREF
 , overwrite = N
 , print     = Y
 , debug     = Y
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
*This document was generated on 2024.08.26 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
