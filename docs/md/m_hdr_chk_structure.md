![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_hdr_chk_structure.sas

### Documentation

##### Header macro to check or verify the program header structure.

***

### Description
This program is used to check if the program header structure is compliant to the standard Doxygen program header commands, together with the toolbox own custom command syntax extension.

 The following Doxygen program header commands are mandatory:

- \file
- \ingroup
- \brief
- \details
- \author
- \date
- \version
- \sa
- \param
- \return
- \calls
- \usage
- \example

 The following Doxygen program header commands are optional:

- \note
- \todo
- \warning



##### *Note:*
*The \\param command is checked for valid suffices [in] and [out]. All other given suffix values will result as invalid.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-08-03 00:00:00

### Version
* 24.1.08

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | in_file | FILEPATH/FILENAME[.sas]. Specifies the full path and file name of the source SAS program or SAS macro header structure to be checked. The default value for IN_FILE is: \_NONE\_. |
| Input | out_tbl | [LIBREF.TABLE]. Optional. Full qualified name containing the header command summary info. The default value for OUT_TBL is: \_NONE\_. |
| Input | err_tbl | [LIBREF.TABLE]. Optional. Full qualified name containing the header exceptions summary info. The default value for OUT_TBL is: \_NONE\_. |
| Input | cmd_lst | CMD1[CMD2..CMDn]. Parameter to specify an ordered list of valid Doxygen header command statements. |
| Input | lbl_lst | Label1[Label2..Labeln]. Parameter to specify an ordered list of labels for each Doxygen header command statement listed in CMD_LST. |
| Input | opt_lst | Optional. List [CMD1[CMD2..CMDn]] parameter that contains Doxygen header command statements which are valid if these are placed directly after the details header command section. |
| Input | print | [Y/N]. Boolean parameter to generate the output by using proc report steps with style HtmlBlue. The default value for PRINT is: N. |
| Input | sendmail | [Y/N]. Boolean parameter to specify if a result summary document in PDF format will be send to one of more addresses defined by the MAILADDR parameter. The default value is: N. |
| Input | mailaddr | [EMAILADDRESS]. Optional. Specifies one or more email addresses to which notifications will be send to. When using more than one address, the parameter contains a list of email addresses seperated by a blank character. |
| Input | debug | [Y/N]. Boolean parameter to provide verbose mode information. The default value is: N. |

### Returns
* A result summary of the program header status.

### Calls
* [m_utl_hash_lookup.sas](m_utl_hash_lookup.md)
* [m_utl_mail_notification.sas](m_utl_mail_notification.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_hdr_chk_structure(?)
```

##### Example 2: Check header syntax and print a result summary report in html:
```sas
%m_hdr_chk_structure(
   in_file = %str(&APPL_PRGM./m_hdr_chk_structure.sas)
 , print   = Y
 , debug   = N
   );
```

##### Example 3: Check header syntax and mail a result summary report in pdf format:
```sas
%m_hdr_chk_structure(
   in_file  = %str(&APPL_PRGM./m_hdr_chk_structure.sas)
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
 , debug    = N
   );
```

##### Example 4: Check header syntax and save the result summary in library WORK:
```sas
%m_hdr_chk_structure(
   in_file = %str(&APPL_PRGM./m_hdr_chk_structure.sas)
 , out_tbl = WORK.header_result
 , print   = N
 , debug   = N
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
*This document was generated on 2024.08.03 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
