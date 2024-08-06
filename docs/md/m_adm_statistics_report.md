![../../misc/images/doc_banner.png](../../misc/images/doc_banner.png)
# 
# File Reference: m_adm_statistics_report.sas

### Admin

##### Admin macro to create the SAS server usage statistics report.

***

### Description
The macro creates a report containing the server load and usage statistics. The statistics are collected by parsing the SAS Metadata Server and Workspace Server log files and performs statistical analyses on the parsed connection data.

 The macro contains the following time analysis modes:

- HIS : to analyse all historical data
- Y2D : to analyse year-to-date data
- 12M : to analyse last 12 months data
- 6M : to analyse last 6 months data
- 3M : to analyse last 3 months data
- 1M : to analyse last month data

 The macro contains the following result report types:

- ALL : complete connection analysis
- DAY : connection analysis per day
- DIR : connection analysis per directory
- HRS : connection analysis per hour
- MTH : connection analysis per month
- USR : connection analysis per user
- WDAY : connection analysis per weekday

 The result information is presented by a SAS graph or plot step and can be send by email as an PDF format attachment.



### Authors
* Paul Alexander Canals y Trocha (paul.canals@gmail.com)
* Dr. Simone Kossmann (simone.kossmann@web.de)

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
| Input | rootdir | Parameter charater string containing the full path to the SAS Toolbox root directory. |
| Input | mslogs | Parameter charater string containing the full path to the SAS Metadata Server log directory. |
| Input | wslogs | Parameter charater string containing the full path to the SAS ObjectSpawner log directory. |
| Input | mode | Indicator [HIS/Y2D/12M/6M/3M/1M] to define the time span of the statistics to be analysed. The default value is: Y2D. |
| Input | type | Indicator [ALL/DAY/DIR/HRS/MTH/USR/WDAY] to define the analysis type. The default value is: ALL. |
| Input | interpol | Boolean [Y/N] parameter to define if the result of the actual month for Y2D connection analysis is to be interpolated. The default value is: N. |
| Input | lastdate | Last date to be analyzed: The date needs to be provided in the DDMMYYYY format. This parameter has no effect if analysis mode is set to Y2D. The default value is TODAY - 1 (Yesterday). |
| Input | firstday | Indicator [S/SUN/M/MON] to define the first day of the week. The default parameter value S for Sunday can beset to M for Monday if necessary. Changing this value has an impact on the report types DAY and WDAY only. |
| Input | topusers | Parameter to define the number of users to be displayed in the user analysis chart. The default value is: 5. |
| Input | excltype | Parameter character string containing the user type to be excluded from the statistics result. The default value is: \@saspw. |
| Input | excluser | Parameter character string containing a _blank_ separated list of users to be excluded from the statistics result. The default value is: sastrust sasevs sassrv. |
| Input | radius | Parameter to specify the the of the pie and donut size in their respective charts. The default value for RADIUS is: 15. |
| Input | print | Boolean [Y/N] parameter to generate the output by a proc report step with style HtmlBlue. The default value is N. |
| Input | sendmail | Boolean [Y/N] parameter to decide if the result information list is to be send to email address. The default value is N. |
| Input | mailaddr | Send to email address of private person or group. |
| Input | debug | Boolean [Y/N] parameter to provide verbose mode information. The default value is: N. |

### Returns
* Server usage reports

### Calls
* [m_utl_delete_file.sas](m_utl_delete_file.md)
* [m_utl_get_file_list.sas](m_utl_get_file_list.md)
* [m_utl_mail_notification.sas](m_utl_mail_notification.md)
* [m_utl_nlobs.sas](m_utl_nlobs.md)
* [m_utl_print_message.sas](m_utl_print_message.md)
* [m_utl_print_mtrace.sas](m_utl_print_mtrace.md)
* [m_utl_printto.sas](m_utl_printto.md)
* [m_utl_quote_elems.sas](m_utl_quote_elems.md)

### Usage

##### Example 1: Show help information:
```sas
%m_adm_statistics_report(?)
```

##### Example 2: Perform year-to-date monthly user connection analysis.
```sas
%let rc = %sysfunc(filename(fref,.));
%let cd = %sysfunc(pathname(&fref.));
%let rc = %sysfunc(filename(fref));
* Exclude type: \@saspw and user: system from statistics ;
%m_adm_statistics_report(
   rootdir  = %str(&APPL_BASE.)
 , mslogs   = %str(&cd./../SASMeta/MetadataServer/Logs)
 , wslogs   = %str(&cd./../ObjectSpawner/Logs)
 , mode     = Y2D
 , type     = MTH
 , interpol = Y
 , excltype = @saspw
 , excluser = system
 , debug    = N
   );
```

##### Example 3: Perform all time hourly user connection analysis.
```sas
%let rc = %sysfunc(filename(fref,.));
%let cd = %sysfunc(pathname(&fref.));
%let rc = %sysfunc(filename(fref));
* Exclude type: \@saspw and user: system from statistics ;
%m_adm_statistics_report(
   rootdir  = %str(&APPL_BASE.)
 , mslogs   = %str(&cd./../SASMeta/MetadataServer/Logs)
 , wslogs   = %str(&cd./../ObjectSpawner/Logs)
 , mode     = HIS
 , type     = HRS
 , topusers = 5
 , excltype = @saspw
 , excluser = system
 , debug    = N
   );
```

##### Example 4: Perform year-to-date analysis per user with top 5 users.
```sas
%let rc = %sysfunc(filename(fref,.));
%let cd = %sysfunc(pathname(&fref.));
%let rc = %sysfunc(filename(fref));
* Exclude type: \@saspw and user: system from statistics ;
%m_adm_statistics_report(
   rootdir  = %str(&APPL_BASE.)
 , mslogs   = %str(&cd./../SASMeta/MetadataServer/Logs)
 , wslogs   = %str(&cd./../ObjectSpawner/Logs)
 , mode     = Y2D
 , type     = USR
 , topusers = 5
 , excltype = @saspw
 , excluser = system
 , debug    = N
   );
```

##### Example 5: Perform all time complete server connection analysis.
```sas
%let rc = %sysfunc(filename(fref,.));
%let cd = %sysfunc(pathname(&fref.));
%let rc = %sysfunc(filename(fref));
* Exclude type: \@saspw and user: system from statistics ;
%m_adm_statistics_report(
   rootdir  = %str(&APPL_BASE.)
 , mslogs   = %str(&cd./../SASMeta/MetadataServer/Logs)
 , wslogs   = %str(&cd./../ObjectSpawner/Logs)
 , mode     = HIS
 , type     = ALL
 , topusers = 5
 , excltype = @saspw
 , excluser = system
 , debug    = N
   );
```

##### Example 6: Perform a complete server connection analysis for a given month.
```sas
%let rc = %sysfunc(filename(fref,.));
%let cd = %sysfunc(pathname(&fref.));
%let rc = %sysfunc(filename(fref));
* Exclude type: \@saspw and user: system from statistics ;
%m_adm_statistics_report(
   rootdir  = %str(&APPL_BASE.)
 , mslogs   = %str(&cd./../SASMeta/MetadataServer/Logs)
 , wslogs   = %str(&cd./../ObjectSpawner/Logs)
 , mode     = 1M
 , type     = ALL
 , lastdate = %sysfunc(putn(%sysfunc(today()),ddmmyyn8.))
 , firstday = MON
 , topusers = 5
 , excltype = @saspw
 , excluser = system
 , debug    = N
   );
```

##### Example 7: Perform a file system directory analysis for a given month.
```sas
%m_adm_statistics_report(
   rootdir = %str(&APPL_BASE.)
 , mode    = Y2D
 , type    = DIR
 , debug   = Y
   );
```

##### Example 8: Send the year-to-date statistics report as PDF to a given email address.
```sas
%let rc = %sysfunc(filename(fref,.));
%let cd = %sysfunc(pathname(&fref.));
%let rc = %sysfunc(filename(fref));

%m_adm_statistics_report(
   rootdir  = %str(&APPL_BASE.)
 , mslogs   = %str(&cd./../SASMeta/MetadataServer/Logs)
 , wslogs   = %str(&cd./../ObjectSpawner/Logs)
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
 , debug    = N
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
