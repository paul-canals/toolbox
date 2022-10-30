# File Reference: m_utl_enc_passwd.sas

### Utilities

##### Utility macro to generate a SAS encoded or encrypted password.

***

### Description
The macro will encode or encrypt any given password string and returns the result value into a SAS macro variable _PWENCODE. Depending on the installed SAS version and the presence of the SAS/SECURE module the following values for METHOD are valid:
 SAS001 : Uses base64 method to encode passwords.
 SAS002 : Uses a 32-bit key to encode passwords. (Default)
 SAS003 : Uses a 256-bit key plus 16-bit salt value
 to encode passwords (AES encryption). SAS004 : Uses a 256-bit key plus 64-bit salt value
 to encrypt passwords (AES encrytion). SAS005 : Uses a 256-bit key plus 64-bit salt value
 with additional hash iterations to encrypt passwords (AES encrytion).

##### *Note:*
*If the selected method is invalid or could not be found the SAS002 method is used to encode the input password string.*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2020-03-16 00:00:00

### Version
* 20.1.03

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | passwd | Input plain password textual string. The use of special characters as part of the text string is allowed. The maximum length of the password text string is 24. The default value is: \_NONE\_. |
| Input | method | Indicator [SAS001/SAS002/SAS003/SAS004/SAS005] to specify which encoding or encryption method is to be used to encode the PASSWD value. The default method is SAS002 in most cases. SAS002 is also the default method used if you specify an invalid method. |
| Input | mdhash | Boolean [Y/N] parameter to decide wether a hash string containing the password string is to be generated. Please do remember that the password hash string must be decoded before use. For more details on decoding see the m_utl_dec_passwd.sas utility macro routine. The default value is: N. |
| Input | print | Boolean [Y/N] parameter to decide wether output is generated using a proc print or report step. The default value for PRINT is: N. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |
| Output | _pwencode | Output encrypted password or hash string. |

### Returns
* Encrypted password or md5 hash string.

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_enc_passwd(?)
```

##### Example 2: Encrypt a given plain password:
```sas
%m_utl_enc_passwd(
   passwd = R@ce2018
 , method = SAS004
 , print  = Y
 , debug  = Y
   );

%put PWENCODE=&_pwencode.;
```

##### Example 3: Encode a given plain password:
```sas
%m_utl_enc_passwd(
   passwd = R@ce2018
 , mdhash = Y
 , print  = Y
 , debug  = Y
   );

%put MDHASH=&_pwencode.;
```

##### Example 4: Encode a given maximum length password:
```sas
%m_utl_enc_passwd(
   passwd = K3nnwortMitM@ximumLenGTh
 , mdhash = Y
 , print  = Y
 , debug  = Y
   );

%put MDHASH=&_pwencode.;
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
*This document was generated on 30.10.2022 at 09:12:44  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
