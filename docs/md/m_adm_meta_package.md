![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_adm_meta_package.sas

### Admin

##### Admin macro to create a SAS metadata export package.

***

### Description
The batch export tool enable you to perform metadata promotions from an operating system batch script.

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-10-01 00:00:00

### Version
* 23.1.10

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | parm_tbl | Full qualified LIBNAME.TABLENAME name of the table containing information on the metadata objects that are to be exported by the script. |
| Input | platform | Indicator [UNIX/WIN] parameter to specify the platform type that is used to run the batch script. The default value is: WIN. |
| Input | profile | The name of the connection to be used. The connection profile must exist on the system where the export command is executed. You can specify any connection profile that has been created for use with client applications such as SAS Management Console, SAS Data Integration Studio, or SAS OLAP Cube Studio. When you open one of these applications, the available connection profiles are displayed in the drop-down box in the Connect Profile dialog. |
| Input | packname | Name of the SAS metadata package (SPK). |
| Input | packpath | Full path to which the SAS metadata package is to be created. |
| Input | outscript | Full path and name of the export batch script. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* MAKEPKG batch file.

### Calls
* [m_utl_single_quotes.sas](m_utl_single_quotes.md)

### Usage

##### Example 1: Show help information:
```sas
%m_adm_meta_package(?)
```

##### Create export parameter table and make package WIN batch file:
```sas
data WORK.makepkg_prm;
   order = 1;
   object='/Shared Data/';
   output;
   order = 2;
   object='/Shared Data/SASApp - SASDATA(Library)';
   output;
run;

%m_adm_meta_package(
   parm_tbl  = WORK.makepkg_prm
 , platform  = WIN
 , profile   = %str(pact@hermes.pact.sas.com)
 , packname  = shared_data.spk
 , packpath  = %str(&APPL_PRGM./source/sas/misc/meta)
 , outscript = %str(&USER_HOME./makepkg.bat)
 , debug     = N
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
*This document was generated on 12.02.2024 at 06:35:33  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v23.1.10)*
