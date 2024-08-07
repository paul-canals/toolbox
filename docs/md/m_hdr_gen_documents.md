![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_hdr_gen_documents.sas

### Documentation

##### Header macro to generate documentation for programs or macros.

***

### Description
This program is used to read all programs in a given directory to create Markdown, PDF, or RTF formatted documents based using the Doxygen header structure in each SAS program or macro file.

 The header needs to comply to the Doxygen command structure to be able to use this program.

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
*The \param command is checked for valid suffices [in] and [out]. All other given suffix values will result as invalid.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2024-06-30 00:00:00

### Version
* 24.1.06

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | in_dir | Specifies the full path and directory name where the source SAS programs or macros resides. These programs must include a header including example code that will be used for generating the scripts. The default value for IN_DIR is: \_NONE\_. |
| Input | out_dir | Specifies the full path and directory name where the generated test scripts are to be created in. The default value for OUT_DIR is: \_NONE\_. |
| Input | exc_lst | Optional. A list [CMD1[CMD2..CMDn]] of optional Doxygen header commands which are to be ignored. |
| Input | doc_type | Indicator [MD/PDF/RTF] to specify the format type. The default value for DOC_TYPE is: MD. |
| Input | doc_image | Optional. Specifies an image file name including a full or relative path. If an image file is set it will be located on top of the output MD file. |
| Input | doc_name | Optional. Specifies the output file name in case of parameter APPEND value is set to: Y. The file extension part is defined by the DOC_TYPE value. The default value for DOC_NAME is: reference. |
| Input | doc_vers | Optional. Specifies the document version value in case of parameter APPEND value is set to: Y. The default value for DOC_VERS is set to: NULL. |
| Input | doc_title | Optional. Specifies an optional title value for the output document files in OUT_DIR, but only when the APPEND parameter value is set to: Y. |
| Input | doc_author | Optional. Specifies an optional author value for the output document files in OUT_DIR. |
| Input | doc_subject | Optional. Specifies an optional subject value for the output document file in OUT_DIR. |
| Input | append | Optional. Boolean [Y/N] parameter to specify whether to output into a single document or into separate program documentation files. If set to (Y)es, the program documentation will be loaded into a single document in the format that is set by the DOC_TYPE parameter value. The default value for APPEND is: N. |
| Input | print | Boolean [Y/N] parameter to generate the output by using proc report steps with style HtmlBlue. The default value for PRINT is: N. |
| Input | sendmail | Boolean [Y/N] parameter to specify if a result summary document in PDF format will be send to one of more addresses defined by the MAILADDR parameter. The default value is: N. |
| Input | mailaddr | Specifies one or more email addresses to which notifications will be send to. In case of more than one email address, the parameter contains a list of email addresses seperated by a blank. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Directory with the generated program or macro documentation.

### Calls
* [m_hdr_crt_md_file.sas](m_hdr_crt_md_file.md)
* [m_hdr_crt_pdf_file.sas](m_hdr_crt_pdf_file.md)
* [m_hdr_crt_rtf_file.sas](m_hdr_crt_rtf_file.md)
* [m_utl_create_dir.sas](m_utl_create_dir.md)
* [m_utl_get_file_list.sas](m_utl_get_file_list.md)
* [m_utl_ods_output.sas](m_utl_ods_output.md)
* [m_utl_nlobs.sas](m_utl_nlobs.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_printto.sas](m_utl_printto.md)

### Usage

##### Example 1: Show help information:
```sas
%m_hdr_gen_documents(?)
```

##### Example 2: Generate MD documentation into temporary folder in WORK:
```sas
%m_hdr_gen_documents(
   in_dir      = %str(&APPL_PRGM.)
 , out_dir     = %str(%sysfunc(getoption(WORK))/misc/docs)
 , doc_type    = MD
 , doc_image   = %str(../../misc/images/doc_banner.png)
 , print       = Y
 , debug       = N
   );
```

##### Example 3: Generate PDF documentation into temporary folder in WORK:
```sas
%m_hdr_gen_documents(
   in_dir      = %str(&APPL_PRGM.)
 , out_dir     = %str(%sysfunc(getoption(WORK))/misc/docs)
 , doc_type    = PDF
 , doc_title   = SAS PDF Documentation Reference
 , doc_author  = Paul Alexander Canals y Trocha
 , doc_subject = Generated SAS Documentation
 , print       = Y
 , debug       = N
   );
```

##### Example 4: Generate consolidated RTF documentation with cover in WORK:
```sas
%m_hdr_gen_documents(
   in_dir      = %str(&APPL_PRGM.)
 , out_dir     = %str(%sysfunc(getoption(WORK))/misc/docs)
 , doc_type    = RTF
 , doc_image   = %str(&APPL_BASE./misc/images/toolbox.jpg)
 , doc_name    = %str(Reference Manual)
 , doc_title   = %str(Paul%'s SAS Macro Utility Toolbox)
 , doc_author  = Paul Alexander Canals y Trocha
 , doc_subject = Generated SAS Documentation
 , append      = Y
 , print       = Y
 , debug       = N
   );
```

##### Example 5: Generate consolidated RTF documentation and output report by email:
```sas
*%m_hdr_gen_documents(
*   in_dir      = %str(&APPL_PRGM.)
* , out_dir     = %str(%sysfunc(getoption(WORK))/misc/docs)
* , doc_type    = RTF
* , doc_title   = SAS RTF Documentation Reference
* , doc_author  = Paul Alexander Canals y Trocha
* , doc_subject = Generated SAS Documentation
* , sendmail    = Y
* , mailaddr    = %str(pact@hermes.local)
* , debug       = N
*   );
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
*This document was generated on 2024.06.30 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
