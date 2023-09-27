![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_utl_set_date.sas

### Utilities

##### Utility macro to convert a given date by day pointer or format.

***

### Description
The macro converts a given date by day pointer and/or format, as also returns a list of dates based on the given day date:
 given day date
 [actual|first|middle|last] day of [actual|last|next] month
 [actual|first|middle|last] day of [actual|last|next] quarter
 [actual|first|middle|last] day of [actual|last|next] year


### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)

### Date
* 2023-08-15 00:00:00

### Version
* 23.1.08

### Link
* https://github.com/paul-canals/toolbox

### Parameters
| Type | Name | Description |
| ---- | ---- | ----------- |
| Input | help | Parameter, if set ( or ?) to print the Help information in the log. In all other cases this parameter should be left out from the macro call. |
| Input | in_date | Specifies the valid date selection for evaluating the output reporting dates list. The parameter value has to be specified by using the following format: DD.MM.YYYY. The default value is: \_NONE\_. |
| Input | dat | Alias of the IN_DATE= parameter. |
| Input | date_fmt | Specifies the output date format to be used. The default value for DATE_FMT is: DDMMYYP10. |
| Input | fmt | Alias of the DATE_FMT= parameter. |
| Input | date_pnt | Parameter [SAMEDAY/BEGIN/MIDDLE/END] to specify the day pointer to be used for the output date list values of macro vars MVAR_DT1 to MVAR_DT4. The default value for DATE_PNT is: SAMEDAY. |
| Input | pnt | Alias of the DATE_PNT= parameter. |
| Input | list_pnt | Parameter [SAMEDAY/LAST/NEXT] to specify the date list pointer to be used for the output date list values of macro vars MVAR_DT1 to MVAR_DT4. The default value for LIST_PNT is: SAMEDAY. |
| Input | special | Boolean [Y/N] parameter to specify if the date selection considers accounting date values. This If set to Yes, it checks if the actual date is the first month and quarter of the year range, and also if the LIST_PNT parameter is set to LAST. If this is the case, the year value of MVAR_DT4 is set to before last year (-2 years). The default value for SPECIAL is: N. |
| Input | global | Boolean [Y/N] Parameter to specify wether the MVAR_x parameter values will be declared as global SAS macro variables. If set to N, the MVAR_x parameter values will not be returned outside this macro. The default value is: N. |
| Input | inline | Boolean [Y/N] Parameter to specify whether the macro returns the MVAR_DT1 value inline inside SAS procedure step. The default value is: N. |
| Input | mvar_dt1 | Name of the macro variable containing the input date value by the IN_DATE parameter. The default value for MVAR_DT1 is: _date1_. |
| Input | mvar_dt2 | Name of the macro variable containing the month date based on the IN_DATE parameter. The default value for MVAR_DT2 is: _date2_. |
| Input | mvar_dt3 | Name of the macro variable containing the quarter date based on the IN_DATE parameter. The default value for MVAR_DT3 is: _date3_. |
| Input | mvar_dt4 | Name of the macro variable containing the year date based on the IN_DATE parameter. The default value for MVAR_DT4 is: _date4_. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
*

### Calls
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)

### Usage

##### Example 1: Show help information
```sas
%m_utl_set_date(?)
```

##### Example 2: Get end-of-month day date for given date 14.09.2019:
```sas
%m_utl_set_date(
   in_date  = 14.02.2019
 , date_pnt = end
 , global   = Y
 , mvar_dt2 = end_of_this_month
 , debug    = N
   )
%put &=end_of_this_month.;
```

##### Example 3: Get beginning-of-month day date for given date 14.09.2019:
```sas
%m_utl_set_date(
   in_date  = 14.09.2019
 , date_pnt = begin
 , global   = Y
 , mvar_dt2 = begin_of_this_month
 , debug    = N
   )
%put &=begin_of_this_month.;
```

##### Example 4: Get last month day date for given date 14.09.2019:
```sas
%m_utl_set_date(
   in_date  = 14.09.2019
 , date_pnt = end
 , list_pnt = last
 , global   = Y
 , mvar_dt2 = end_of_last_month
 , debug    = N
   )
%put &=end_of_last_month.;
```

##### Example 5: Get next month day date for given date 14.09.2019:
```sas
%m_utl_set_date(
   in_date  = 14.09.2019
 , date_pnt = sameday
 , list_pnt = next
 , global   = Y
 , mvar_dt2 = same_day_next_month
 , debug    = N
   )
%put &=same_day_next_month.;
```

##### Example 6: Get ultimo day date results for given date 14.09.2019:
```sas
%m_utl_set_date(
   in_date  = 14.09.2019
 , date_pnt = end
 , global   = Y
 , mvar_dt1 = input_day_date
 , mvar_dt2 = end_of_this_month
 , mvar_dt3 = end_of_this_quarter
 , mvar_dt4 = end_of_this_year
 , debug    = N
   )
%put &=input_day_date.;
%put &=end_of_this_month.;
%put &=end_of_this_quarter.;
%put &=end_of_this_year.;
```

##### Example 7: Convert date format for given date 14.09.2019:
```sas
%let formatted_date=
   %m_utl_set_date(
      dat    = 14.09.2019
    , fmt    = date9
    , inline = Y
    , debug  = N
      );
%put &=formatted_date.;
```

##### Example 8: Convert date format for given date 14.09.2019:
```sas
%let formatted_date=
   %m_utl_set_date(
      dat    = 14.09.2019
    , fmt    = yymmddn8
    , inline = Y
    , debug  = N
      );
%put &=formatted_date.;
```

##### Example 9: Convert date format and set day for given date 14.09.2019:
```sas
%let formatted_date=
   %m_utl_set_date(
      dat    = 14.09.2019
    , fmt    = date9
    , pnt    = E
    , inline = Y
    , debug  = N
      );
%put &=formatted_date.;
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
*This document was generated on 26.09.2023 at 15:41:51  by Paul's SAS&reg; Toolbox macro: m_hdr_crt_md_file.sas (v21.1.04)*
