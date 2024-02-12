![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_test_generate_scripts.sas

### Testing

##### Testing macro to generate test scripts for programs or macros.

***

### Description
This program is used to read all programs in a given folder and create test scripts based on the usage example code that are contained in the SAS program or macro header comments. The following Doxygen program header commands are mandatory:
 \\file
 \\ingroup
 \\brief
 \\details
 \\author
 \\date
 \\version
 \\sa
 \\param
 \\return
 \\calls
 \\usage
 \\example
 The following Doxygen program header commands are optional:
 \\note
 \\todo
 \\warning


### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-11-19 00:00:00

### Version
* 23.1.11

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | src_path | Specifies the full path and directory name where the source SAS programs or macros resides. These programs must include a header including example code that will be used for generating the scripts. The default value for SRC_PATH is: \_NONE\_. |
| Input | tgt_path | Specifies the full path and directory name where the generated test scripts are to be created in. The default value for TGT_PATH is: \_NONE\_. |
| Input | opt_lst | Optional. List [CMD1[CMD2..CMDn]] parameter that contains Doxygen header command statements which are valid if these are placed directly after the details header command section. |
| Input | print | Boolean [Y/N] parameter to generate the output by using proc report steps with style HtmlBlue. The default value for PRINT is: N. |
| Input | sendmail | Boolean [Y/N] parameter to specify if a result summary document in PDF format will be send to one of more addresses defined by the MAILADDR parameter. The default value is: N. |
| Input | mailaddr | Specifies one or more email addresses to which notifications will be send to. In case of more than one email address, the parameter contains a list of email addresses seperated by a blank. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Directory with the generated test scripts.

### Calls
* [m_hdr_chk_structure.sas](m_hdr_chk_structure.md)
* [m_utl_create_dir.sas](m_utl_create_dir.md)
* [m_utl_get_file_list.sas](m_utl_get_file_list.md)
* [m_utl_nlobs.sas](m_utl_nlobs.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_printto.sas](m_utl_printto.md)

### Usage

##### Example 1: Show help information:
```sas
%m_test_generate_scripts(?)
```

##### Example 2: Generate test scripts into temporary folder in WORK:
```sas
%m_test_generate_scripts(
   src_path = %str(&APPL_PRGM.)
 , tgt_path = %str(%sysfunc(getoption(WORK))\misc\tests)
 , print    = Y
 , debug    = N
   );
```

##### Example 3: Generate test scripts and output report by email:
```sas
%m_test_generate_scripts(
   src_path = %str(&APPL_PRGM.)
 , tgt_path = %str(%sysfunc(getoption(WORK))\misc\tests)
 , sendmail = Y
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
*This document was generated on 12.02.2024 at 06:36:02  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v23.1.10)*
