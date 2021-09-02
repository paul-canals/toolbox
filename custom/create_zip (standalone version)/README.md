![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_uc_create_zip.sas

### Custom

##### Custom macro to copy files and directory tree into a ZIP file.

***

### Description
This program copies all files from a given directory including sub directories preserving the directory structure or it copies a single selected file defined by the INDIR into a ZIP archive. The macro uses the ODS package function or a fileref to create the archive. The ODS package archiving is restricted to a single source file size maximum of 4GB. This means that if a file has an uncompressed size larger than 4 GB, an error is returned. The ZIP fileref function comes without this restriction and is available since SAS 9.4. However when archiving a large number of files the ZIP fileref function can be much slower than with using ODS package ZIP archiving function. Therefore the program has a third and default runmode that combines both ODS archiving and ZIP fileref to overcome both the ODS 4GB restriction and the ZIP fileref problem. The zip file creation ignores locked files, which are excluded gracefully from the zip archiving routine.

##### *Note:*
*This program is able to work in system environments where x-command or unix pipes are not allowed or cannot be used.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2021-09-01 00:00:00

### Version
* 21.1.09

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
| Input | runmode | Indicator [A/F/O] specify whether the macro uses the (O)DS package function, the (F)ileref or the default (A)uto mode for which a combination of ODS archiving and Fileref is selected to create the archive. The default value is: A. |
| Input | overwrite | Boolean [Y/N] parameter to specify wether to overwrite or appended to an existing archive. The default value is: Y. |
| Input | subdirs | Boolean [Y/N] parameter to decide if the file list is to include files in sub directories under ROOTDIR. The default value is: N. |
| Input | print | Boolean [Y/N] parameter to generate the output by a proc print step. The default value is N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* The program returns a ZIP archive

### Calls
* None

### Usage

##### Example 1: Show help information:
```sas
%m_uc_create_zip(?)
```

##### Example 2: Copy SAS core samples into a ZIP file using Auto mode:
```sas
%m_uc_create_zip(
   indir   = %sysget(SASROOT)/core/sample
 , outdir  = %sysfunc(getoption(WORK))/backup
 , zipname = &sysuserid._samples.zip
 , runmode = AUTO
 , print   = Y
 , debug   = Y
   );
```

##### Example 3: Copy SAS core samples into a ZIP file using ODS package (fast):
```sas
%m_uc_create_zip(
   indir     = %sysget(SASROOT)/core/sasmisc
 , outdir    = %sysfunc(getoption(WORK))/backup
 , zipname   = &sysuserid._sasmisc_ods.zip
 , runmode   = ODS
 , overwrite = Y
 , subdirs   = Y
 , print     = Y
 , debug     = Y
   );
```

##### Example 4: Copy SAS core samples into a ZIP file using ZIP fileref (slow):
```sas
%m_uc_create_zip(
   indir     = %sysget(SASROOT)/core/sasmisc
 , outdir    = %sysfunc(getoption(WORK))/backup
 , zipname   = &sysuserid._sasmisc_ref.zip
 , runmode   = FILEREF
 , overwrite = Y
 , subdirs   = Y
 , print     = Y
 , debug     = Y
   );
```

##### Example 5: Copy a single file into a ZIP archive using Auto mode:
```sas
%m_uc_create_zip(
   infile    = %sysget(SASROOT)/core/sashelp/class.sas7bdat
 , outdir    = %sysfunc(getoption(WORK))/backup
 , runmode   = AUTO
 , print     = Y
 , debug     = Y
   );
```

### Copyright
Copyright 2008-2021 Paul Alexander Canals y Trocha. 
 
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
*This document was generated on 02.09.2021 at 14:46:27  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
