/*!
 ******************************************************************************
 * \file       m_log_xxx.sas
 * \ingroup    Documentation
 * \brief      Header macro to <one-line description of the macro function>.
 * \details    The macro <detailed description of the macro function>.  
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       yyyy-mm-dd hh:mm:ss
 * \version    YY.x
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \param[in]  help        Parameter, if set (Help or ?) to print the Help 
 *                         information in the log. In all other cases this
 *                         parameter should be left out from the macro call.
 * \param[in]  <name>      <description of the macro parameter>
 * \param[in]  debug       Boolean [Y|N] parameter to provide verbose
 *                         mode information. The default value is: N.
 * 
 * \return     <Describe what is returned by the macro>
 * 
 * \calls
 *             + m_utl_print_message.sas
 * 
 * \usage
 * 
 * \example    Example 1: Show help information
 * \code
 *             %m_hdr_xxx(?)
 * \endcode
 * 
 * \copyright  Copyright 2008-2023 Paul Alexander Canals y Trocha.
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
%macro m_hdr_xxx(
   help
 , vers  = YY.x
 , ...
 , debug = N
   );


%mend m_hdr_xxx;
