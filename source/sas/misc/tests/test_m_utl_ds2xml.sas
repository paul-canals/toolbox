/*!
 ******************************************************************************
 * \file       test_m_utl_ds2xml.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-06-16 00:00:00
 * \version    24.1.06
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_ds2xml.sas
 * 
 * \copyright  Copyright 2008-2024 Paul Alexander Canals y Trocha
 * 
 *     This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     (at your option) any later version.
 * 
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 * 
 *     You should have received a copy of the GNU General Public License
 *     along with this program. If not, see <https://www.gnu.org/licenses/>.
 * 
 ******************************************************************************
 */
 
%* Example 1: Show help information: ;
%m_utl_ds2xml(?)
 
%* Example 2: Export a SAS dataset into a generic format XML file: ;
%m_utl_ds2xml(
   base_ds  = SASHELP.class
 , xml_file = %sysfunc(getoption(WORK))/class.xml
 , debug    = Y
   );

filename class "%sysfunc(getoption(WORK))/class.xml";

data _null_;
   infile class;
   input;
   put _infile_;
run;

filename class clear;
 
%* Example 3: Export a SAS dataset into a Ms. Access format XML file: ;
%m_utl_ds2xml(
   base_ds  = SASHELP.classfit
 , xml_file = %sysfunc(getoption(WORK))/classfit.xml
 , xmltype  = MSACCESS
 , debug    = Y
   );

filename classfit "%sysfunc(getoption(WORK))/classfit.xml";

data _null_;
   infile classfit;
   input;
   put _infile_;
run;

filename classfit clear;
 
%* Example 4: Export a selection of a SAS dataset into a XML file: ;
%m_utl_ds2xml(
   base_ds  = SASHELP.cars
 , xml_file = %sysfunc(getoption(WORK))/cars.xml
 , where    = %str(upcase(Make) = 'AUDI')
 , debug    = Y
   );

filename cars "%sysfunc(getoption(WORK))/cars.xml";

data _null_;
   infile cars;
   input;
   put _infile_;
run;

filename cars clear;
 
%* Example 5: Export a selection of a SAS dataset into a XML file: ;
%m_utl_ds2xml(
   base_ds  = SASHELP.cars
 , xml_file = %sysfunc(getoption(WORK))/cars.xml
 , varlist  = %str(Make Model Type Origin)
 , where    = %str(upcase(Make) = 'AUDI')
 , debug    = Y
   );

filename cars "%sysfunc(getoption(WORK))/cars.xml";

data _null_;
   infile cars;
   input;
   put _infile_;
run;

filename cars clear;
 
%* Example 6: Export an encrypted SAS dataset into a XML file: ;
data WORK.class(encrypt=aes encryptkey=aespasskey);
   set SASHELP.class;
run;

%m_utl_ds2xml(
   base_ds  = WORK.class
 , xml_file = %sysfunc(getoption(WORK))/class.xml
 , password = aespasskey
 , debug=Y
   );

filename class "%sysfunc(getoption(WORK))/class.xml";

data _null_;
   infile class;
   input;
   put _infile_;
run;

filename class clear;
 
%* Example 7: Export a SAS dataset into a XML data and a XSD schema file: ;
%m_utl_ds2xml(
   base_ds   = SASHELP.class
 , xml_file  = %sysfunc(getoption(WORK))/class.xml
 , xmlschema = %sysfunc(getoption(WORK))/class.xsd
 , debug     = Y
   );

filename class "%sysfunc(getoption(WORK))/class.xsd";

data _null_;
   infile class;
   input;
   put _infile_;
run;

filename class clear;
 
%* Example 8: Export a SAS dataset into a XML file with UTF-8 encoding: ;
%m_utl_ds2xml(
   base_ds     = SASHELP.class
 , xml_file    = %sysfunc(getoption(WORK))/class.xml
 , xmlencoding = %str('utf-8')
 , debug       = Y
   );

filename class "%sysfunc(getoption(WORK))/class.xml";

data _null_;
   infile class;
   input;
   put _infile_;
run;

filename class clear;
 
%* Example 9: Step 1 - Create a SAS dataset TEAMS using data-cards: ;
data WORK.teams ;
attrib
   NAME        length= $30  format=$30.  label='NAME'
   ABBREV      length= $3   format=$3.   label='ABBREV'
   CONFERENCE  length= $10  format=$10.  label='CONFERENCE'
   DIVISION    length= $10  format=$10.  label='DIVISION'
;
infile cards dsd delimiter=',' truncover;
input
   NAME        :$char.
   ABBREV      :$char.
   CONFERENCE  :$char.
   DIVISION    :$char.
;
datalines4;
"Thrashers","ATL","Eastern","Southeast"
"Hurricanes","CAR","Eastern","Southeast"
"Panthers","FLA","Eastern","Southeast"
"Lightning","TB","Eastern","Southeast"
"Capitals","WSH","Eastern","Southeast"
"Stars","DAL","Western","Pacific"
"Kings","LA","Western","Pacific"
"Ducks","ANA","Western","Pacific"
"Coyotes","PHX","Western","Pacific"
"Sharks","SJ","Western","Pacific"
;;;;
run;
 
%* Example 9: Step 2 - Create a XML map file for TEAMS table: ;
filename nhl_map "%sysfunc(getoption(WORK))/nhl.map";

data _null_;
   file nhl_map;
   put '<?xml version="1.0" ?>';
   put '<SXLEMAP version="1.2">';
   put '   <TABLE name="TEAMS">';
   put '      <TABLE-PATH syntax="XPATH">/NHL/CONFERENCE/DIVISION/TEAM</TABLE-PATH>';
   put '         <COLUMN name="NAME">';
   put '            <PATH>/NHL/CONFERENCE/DIVISION/TEAM/@name</PATH>';
   put '            <TYPE>character</TYPE>';
   put '            <DATATYPE>STRING</DATATYPE>';
   put '            <LENGTH>30</LENGTH>';
   put '         </COLUMN>';
   put '         <COLUMN name="ABBREV">';
   put '            <PATH>/NHL/CONFERENCE/DIVISION/TEAM/@abbrev</PATH>';
   put '            <TYPE>character</TYPE>';
   put '            <DATATYPE>STRING</DATATYPE>';
   put '            <LENGTH>3</LENGTH>';
   put '         </COLUMN>';
   put '         <COLUMN name="CONFERENCE" retain="YES">';
   put '            <PATH>/NHL/CONFERENCE</PATH>';
   put '            <TYPE>character</TYPE>';
   put '            <DATATYPE>STRING</DATATYPE>';
   put '            <LENGTH>10</LENGTH>';
   put '         </COLUMN>';
   put '         <COLUMN name="DIVISION" retain="YES">';
   put '            <PATH>/NHL/CONFERENCE/DIVISION</PATH>';
   put '            <TYPE>character</TYPE>';
   put '            <DATATYPE>STRING</DATATYPE>';
   put '            <LENGTH>10</LENGTH>';
   put '         </COLUMN>';
   put '   </TABLE>';
   put '</SXLEMAP>';
run;

data _null_;
   infile nhl_map;
   input;
   put _infile_;
run;

filename nhl_map clear;
 
%* Example 9: Step 3 - Export TEAMS table into XML by using a XML map file: ;
%m_utl_ds2xml(
   base_ds  = WORK.teams
 , xml_file = %sysfunc(getoption(WORK))/nhl.xml
 , xmlmap   = %sysfunc(getoption(WORK))/nhl.map
 , debug    = Y
   );

filename nhl "%sysfunc(getoption(WORK))/nhl.xml";

data _null_;
   infile nhl;
   input;
   put _infile_;
run;

filename nhl clear;
 
