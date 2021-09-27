# File Reference: m_utl_read_hist_data.sas

### Utilities

##### Utility macro to extract data from a historised SAS dataset.

***

### Description
This macro can be used to extract data from a historised table or dataset using a combination of valid date and version number as historisation attributes. Unless given as a parameter value, the macro routine returns a selection of data for a given date using the maximum version number value related to that date.

##### *Note:*
*SAS Problem Note 2859: LOCK statement or function with LIST or QUERY options might report locks incorrectly:
 http://support.sas.com/kb/2/859.html
*

### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2021-02-08 00:00:00

### Version
* 21.1.02

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set (Help or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | in_tbl | Specifies the full LIBNAME.TABLENAME name of the source SAS dataset or database table. This parameter may contain a combination of data step style statement between brackets like keep=, drop= or rename=. The default value for IN_TBL is: \_NONE\_. |
| Input | intable | Alias of the IN_TBL= parameter. |
| Input | out_tbl | Specifies the full LIBNAME.TABLENAME name of the target SAS dataset or database table. The default value for OUT_TBL is: \_NONE\_. |
| Input | outtable | Alias of the OUT_TBL= parameter. |
| Input | where | Optional. Specifies a valid WHERE clause that selects observations from the IN_TBL SAS dataset. Using this argument subsets your data based on the criteria that you supply for the expression. |
| Input | valid_dt | Specifies the valid date selection for filtering the data content. The value is to be specified by using the following format: _DD.MM.YYYY_. |
| Input | datecol | Specifies the name of valid date selection column. The default value is: VALID_DT. |
| Input | version | Optional. Specifies the of the valid date selection for filtering the data content. |
| Input | verscol | Specifies the name of version selection column. The default value is: VERSION_NR. |
| Input | type_cd | Optional. Specifies the result type code selection for filtering the data content. |
| Input | typecol | Specifies the name of result type selection column. The default value is: RESULT_CD. |
| Input | timeout | Specifies the waiting time in seconds to wait until alock can be set on the input SAS dataset. The default value is: 300. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Data selection from a historised SAS dataset input table.

### Calls
* [m_utl_clr_table_lock.sas](m_utl_clr_table_lock.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_nlobs.sas](m_utl_nlobs.md)
* [m_utl_set_table_lock.sas](m_utl_set_table_lock.md)

### Usage

##### Example 1: Show help information:
```sas
%m_utl_read_hist_data(?)
```

##### Example 2: Read most actual data from a historised table WORK.class:
```sas
data WORK.class;
   set SASHELP.class;
   attrib LOAD_ID   length=8 format=z8.;
   attrib LOAD_CD   length=$32.;
   attrib VALID_DT length=8 format=ddmmyyp10.;
   attrib VERSION  length=8 format=z5.;
   attrib LOAD_DTTM length=8 format=datetime20.;
   load_id   = 1;
   load_cd   = '';
   valid_dt  = "30sep2017"d;
   version   = 1;
   load_dttm = datetime()-2000;
   output;
   load_id   = 2;
   load_cd   = '';
   valid_dt  = "30sep2017"d;
   version   = 2;
   load_dttm = datetime()-1000;
   output;
   load_id   = 3;
   load_cd   = '';
   valid_dt  = date();
   version   = 1;
   load_dttm = datetime();
   output;
run;

%m_utl_read_hist_data(
   intable  = WORK.class (drop=Height Weight)
 , out_tbl  = WORK.students
 , where    = %str(Sex = 'F' and Age > 13)
 , valid_dt = 30.09.2017
 , verscol  = version
 , debug    = Y
   );

proc print data=WORK.students;
run;
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
*This document was generated on 27.09.2021 at 15:29:17  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
