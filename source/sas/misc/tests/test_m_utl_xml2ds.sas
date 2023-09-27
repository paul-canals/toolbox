/*!
 ******************************************************************************
 * \file       test_m_utl_xml2ds.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-26 15:38:03
 * \version    20.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_xml2ds.sas
 * 
 * \copyright  Copyright 2008-2023 Paul Alexander Canals y Trocha
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
%m_utl_xml2ds(?)
 
%* Example 2: Step 1 - Export a SAS dataset into a generic XML file: ;
libname MyXML xml "%sysfunc(getoption(WORK))/class.xml"
   xmlmeta=schemadata
   ;

data MyXML.class;
   set SASHELP.class;
run;

libname MyXML clear;
 
%* Example 2: Step 2 - Import the XML file back into a SAS dataset: ;
%m_utl_xml2ds(
   in_file = %str(%sysfunc(getoption(WORK))/class.xml)
 , out_ds  = WORK.class
 , debug   = Y
   );

proc print data=WORK.class;
run;
 
%* Example 3: Step 1 - Export a SAS dataset into a Ms. Access type XML file: ;
libname MyXML xml "%sysfunc(getoption(WORK))/class.xml"
   xmlmeta=schemadata
   xmltype=msaccess
   ;

data MyXML.class;
   set SASHELP.class;
run;

libname MyXML clear;
 
%* Example 3: Step 2 - Import the Ms. Access type XML file into a SAS dataset: ;
%m_utl_xml2ds(
   in_file = %str(%sysfunc(getoption(WORK))/class.xml)
 , out_ds  = WORK.class
 , xmltype = msaccess
 , debug   = Y
   );

proc print data=WORK.class;
run;
 
%* Example 4: Step 1 - Export a SAS dataset into a Ms. Access type XML file: ;
libname MyXML xml "%sysfunc(getoption(WORK))/class.xml"
   xmlmeta=schemadata
   xmltype=msaccess
   ;

data MyXML.class;
   set SASHELP.class;
run;

libname MyXML clear;
 
%* Example 4: Step 2 - Import the XML file into a SAS dataset by automap: ;
%m_utl_xml2ds(
   in_file = %str(%sysfunc(getoption(WORK))/class.xml)
 , out_ds  = WORK.class
 , automap = Y
 , debug   = Y
   );

proc print data=WORK.class;
run;
 
%* Example 5: Step 1 - Created a XML file with nested elements: ;
filename class "%sysfunc(getoption(WORK))/class.xml";

data _null_;
   file class;
   put '<?xml version="1.0" encoding="utf-8" ?>';
   put '<root>';
   put '   <dataroot>';
   put '      <class>';
   put '         <Name>Alfred</Name>';
   put '         <Sex>M</Sex>';
   put '         <Age>14</Age>';
   put '         <Height>69</Height>';
   put '         <Weight>112.5</Weight>';
   put '         <classfit>';
   put '            <predict>126.00617011</predict>';
   put '            <lowermean>116.94168423</lowermean>';
   put '            <uppermean>135.07065599</uppermean>';
   put '            <lower>100.64558742</lower>';
   put '            <upper>151.36675279</upper>';
   put '         </classfit>';
   put '      </class>';
   put '      <class>';
   put '         <Name>Alice</Name>';
   put '         <Sex>F</Sex>';
   put '         <Age>13</Age>';
   put '         <Height>56.5</Height>';
   put '         <Weight>84</Weight>';
   put '         <classfit>';
   put '            <predict>77.268291747</predict>';
   put '            <lowermean>68.906553333</lowermean>';
   put '            <uppermean>85.630030161</uppermean>';
   put '            <lower>52.150311745</lower>';
   put '            <upper>102.38627175</upper>';
   put '         </classfit>';
   put '      </class>';
   put '      <class>';
   put '         <Name>Barbara</Name>';
   put '         <Sex>F</Sex>';
   put '         <Age>13</Age>';
   put '         <Height>65.3</Height>';
   put '         <Weight>98</Weight>';
   put '         <classfit>';
   put '            <predict>111.57975811</predict>';
   put '            <lowermean>105.26025322</lowermean>';
   put '            <uppermean>117.89926301</uppermean>';
   put '            <lower>87.06587649</lower>';
   put '            <upper>136.09363973</upper>';
   put '         </classfit>';
   put '      </class>';
   put '  </dataroot>';
   put '</root>';
run;

data _null_;
   infile class;
   input;
   put _infile_;
run;
 
%* Example 5: Step 2 - Import the nested XML file into SAS datasets by automap: ;
%m_utl_xml2ds(
   in_file = %str(%sysfunc(getoption(WORK))/class.xml)
 , out_ds  = WORK.class
 , automap = Y
 , debug   = Y
   );

proc print data=WORK.class_root noobs;
run;

proc print data=WORK.class_dataroot noobs;
run;

proc print data=WORK.class noobs;
run;

proc print data=WORK.class_classfit noobs;
run;
 
%* Example 5: Step 3 - Join the SAS datasets from Step 2 into one result dataset: ;
proc sql noprint;
   create table WORK.examined as
   select c.Name
        , c.Sex
        , c.Age
        , c.Height
        , c.Weight
        , d.predict
        , d.lowermean
        , d.uppermean
        , d.lower
        , d.upper
     from WORK.class_root as a
        , WORK.class_dataroot as b
        , WORK.class as c
        , WORK.class_classfit as d
    where a.root_ORDINAL = b.root_ORDINAL
      and b.dataroot_ORDINAL = c.dataroot_ORDINAL
      and c.class_ORDINAL = d.class_ORDINAL
    ;
quit;

proc print data=WORK.examined noobs;
run;
 
%* Example 6: Step 1 - Created a XML file with structure and some data: ;
filename nhl_xml "%sysfunc(getoption(WORK))/nhl.xml";

data _null_;
   file nhl_xml;
   put '<?xml version="1.0" encoding="iso-8859-1" ?>';
   put '<NHL>';
   put '   <CONFERENCE> Eastern';
   put '      <DIVISION> Southeast';
   put '         <TEAM name="Thrashers"  abbrev="ATL" />';
   put '         <TEAM name="Hurricanes" abbrev="CAR" />';
   put '         <TEAM name="Panthers"   abbrev="FLA" />';
   put '         <TEAM name="Lightning"  abbrev="TB"  />';
   put '         <TEAM name="Capitals"   abbrev="WSH" />';
   put '      </DIVISION>';
   put '   </CONFERENCE>';
   put '   <CONFERENCE> Western';
   put '      <DIVISION> Pacific';
   put '         <TEAM name="Stars"   abbrev="DAL" />';
   put '         <TEAM name="Kings"   abbrev="LA"  />';
   put '         <TEAM name="Ducks"   abbrev="ANA" />';
   put '         <TEAM name="Coyotes" abbrev="PHX" />';
   put '         <TEAM name="Sharks"  abbrev="SJ"  />';
   put '      </DIVISION>';
   put '   </CONFERENCE>';
   put '</NHL>';
run;

data _null_;
   infile nhl_xml;
   input;
   put _infile_;
run;

filename nhl_xml clear;
 
%* Example 6: Step 2 - Created a XML map file using XML map v1.0 format: ;
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
 
%* Example 6: Step 3 - Import the XML file into a SAS dataset by XML map: ;
%m_utl_xml2ds(
    in_file = %sysfunc(getoption(WORK))/nhl.xml
  , out_ds  = WORK.teams
  , engine  = XML
  , xmltype = XMLMAP
  , xmlmap  = %sysfunc(getoption(WORK))/nhl.map
  , debug   = Y
    );

proc print data=WORK.teams noobs;
run;
 
