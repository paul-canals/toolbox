![../../misc/images/doc_header.png](../../misc/images/doc_header.png)
# 
# File Reference: m_utl_mail_notification.sas

### Utilities

##### Utility macro to send an email notification to a given address.

***

### Description
The macro is used to send an email notification to a given email address or address list including attachments. For this macro to function properly, a working email server must be configured.



### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-12-07 00:00:00

### Version
* 20.1.12

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | sender | Optional. Parameter to specify an alternate address. The value may contain an email address, or or a given name combined with email address using brackets. (e.g. John Doe <john.doe@domain.com>). |
| Input | to | List of email addresses separated by a blank. |
| Input | cc | Optional. List of email addresses separated by a blank. |
| Input | subject | Title or  of the email notification |
| Input | content | The email  (body). |
| Input | attach | Optional. Full path and name to the file to be included to the email as an attachment. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Email send to given address

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_mail_notification(?)
```

##### Example 2: Send an email with an attachment:
```sas
options dlcreatedir;
libname TEMP "%sysfunc(getoption(WORK))/tmpdir";
libname TEMP clear;

filename text "%sysfunc(getoption(WORK))/tmpdir/attachment.txt";

data _null_;
   file text;
   put "This is a test file for mail notification testing";
run;

filename text clear;

%m_utl_mail_notification(
   to      = %str(pact@hermes.local)
 , cc      = %str(admin@hermes.local)
 , subject = %str(RACE: Mail notification test)
 , content = "Your RACE support team"
 , attach  = %sysfunc(getoption(WORK))/tmpdir/attachment.txt
 , debug   = N
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
*This document was generated on 2020.12.07 at 00:00:00 by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas*
