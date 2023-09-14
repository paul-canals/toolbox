![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_hdr_crt_pdf_file.sas

### Documentation

##### Header macro to generate a program or macro PDF documentation.

***

### Description
The macro generates a PDF formatted document containing program or macro information based on the header structure generated by the m_hdr_chk_structure.sas macro. The header has to comply to the standard Doxygen structure to be able to use this program. The following Doxygen program header commands are mandatory:
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


##### *Note:*
*The \\param command is checked for valid suffices [in] and [out]. All other given suffix values will result as invalid.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)
* Dr. Simone Kossmann (simone.kossmann@web.de)

### Date
* 2021-11-09 00:00:00

### Version
* 21.1.11

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | in_file | FILEPATH/FILENAME[.sas]. Specifies the full path and file name of the source SAS program or macro for which the documentation is to be generated. The default value for IN_FILE is: \_NONE\_. |
| Input | out_file | Specifies the full qualified path and file name of the target output PDF formatted document. The default value for OUT_FILE is: \_NONE\_. |
| Input | opt_lst | Optional. List [CMD1[CMD2..CMDn]] parameter that contains Doxygen header command statements which are valid if these are placed directly after the details header command section. |
| Input | doc_image | Optional. Specifies an image file name including a full or relative path. If an image file is set it will be located on top of the output PDF file. |
| Input | doc_title | Optional. Specifies an alternative title name value for the OUT_FILE output PDF document file. If a value is ommitted, the default title will be derived from the IN_FILE file name value. |
| Input | doc_author | Optional. Specifies an optional author name value for the OUT_FILE output PDF document file. |
| Input | doc_subject | Optional. Specifies an optional operator value for the output OUT_FILE PDF document file. |
| Input | compress | Optional. Specifies the level of compression for the output OUT_PDF PDF document. This can be set to an integer value between 0 and 9, which specifies the level of compression. A value of 0 means no compression, and 9 the highest compression. The default level is: 6. |
| Input | append | Optional. Boolean [Y/N] parameter to specify whether to output to an existing PDF document. If set to (Y)es, an ODS PDF statement must have been set before calling this macro. Furthermore a bookmark will be created containing the name of the SAS program being processed. The default value for APPEND is: N. |
| Input | keep_tbl | Optional. Boolean [Y/N] parameter to specify whether to keep the output document header and error SAS datasets to be used after this macro call. The default value for KEEP_TBL is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* SAS program or macro documentation in PDF format.

### Calls
* [m_hdr_chk_structure.sas](m_hdr_chk_structure.md)
* [m_utl_create_dir.sas](m_utl_create_dir.md)
* [m_utl_get_userid.sas](m_utl_get_userid.md)
* [m_utl_nlobs.sas](m_utl_nlobs.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_quote_elems.sas](m_utl_quote_elems.md)

### Usage

##### Example 1: Show help information:
```sas
%m_hdr_crt_pdf_file(?)
```

##### Example 2: Create macro PDF documentation including optional commands:
```sas
%m_hdr_crt_pdf_file(
   in_file  = %str(&APPL_PRGM./m_hdr_crt_pdf_file.sas)
 , out_file = %str(%sysfunc(getoption(WORK))/m_hdr_crt_pdf_file.pdf)
 , opt_lst  = %str(\note \todo \warning)
 , debug    = N
   )
```

##### Example 3: Create macro PDF documentation with optional information:
```sas
%m_hdr_crt_pdf_file(
   in_file     = %str(&APPL_PRGM./m_hdr_crt_pdf_file.sas)
 , out_file    = %str(%sysfunc(getoption(WORK))/m_hdr_crt_pdf_file.pdf)
 , doc_title   = PDF Toolbox Document
 , doc_author  = Paul Alexander Canals y Trocha
 , doc_subject = Generated SAS PDF documentation
 , debug       = N
   )
```

##### Example 4: Create a concatenated macro PDF documentation file:
```sas
ods escapechar='~';
ods pdf file = "%sysfunc(getoption(WORK))/toolbox.pdf"
   title     = "Paul's SAS Macro Utility Toolbox Documentation"
   author    = "Paul Alexander Canals y Trocha"
   subject   = "Generated SAS macro PDF documentation"
   keywords  = "SAS Macro Program Documentation"
   style     = styles.htmlblue
   startpage = never
   ;

%m_hdr_crt_pdf_file(
   in_file  = %str(&APPL_PRGM./m_hdr_crt_pdf_file.sas)
 , out_file = %str(%sysfunc(getoption(WORK))/toolbox.pdf)
 , append   = Y
 , debug    = N
   )

%m_hdr_crt_pdf_file(
   in_file  = %str(&APPL_PRGM./m_hdr_gen_rtf_doc.sas)
 , out_file = %str(%sysfunc(getoption(WORK))/toolbox.pdf)
 , append   = Y
 , debug    = N
   )

ods pdf close;
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
*This document was generated on 13.09.2023 at 15:24:58  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*