/*
 * The contents of this file are subject to the MonetDB Public
 * License Version 1.0 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at 
 * http://monetdb.cwi.nl/Legal/MonetDBLicense-1.0.html
 * 
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 * 
 * The Original Code is the Monet Database System.
 * 
 * The Initial Developer of the Original Code is CWI.
 * Portions created by CWI are Copyright (C) 1997-2002 CWI.  
 * All Rights Reserved.
 * 
 * Contributor(s):
 * 		Martin Kersten <Martin.Kersten@cwi.nl>
 * 		Peter Boncz <Peter.Boncz@cwi.nl>
 * 		Niels Nes <Niels.Nes@cwi.nl>
 * 		Stefan Manegold  <Stefan.Manegold@cwi.nl>
 */

/**********************************************************************
 * SQLSetDescField()
 * CLI Compliance: ISO 92
 **********************************************************************/

#include "ODBCGlobal.h"

SQLRETURN  SQLSetDescField(
	SQLHDESC	DescriptorHandle,
	SQLSMALLINT	RecordNumber,
	SQLSMALLINT	FieldIdentifier,
	SQLPOINTER	Value,
	SQLINTEGER	BufferLength )
{
	(void) DescriptorHandle;	/* Stefan: unused!? */
	(void) RecordNumber;	/* Stefan: unused!? */
	(void) FieldIdentifier;	/* Stefan: unused!? */
	(void) Value;	/* Stefan: unused!? */
	(void) BufferLength;	/* Stefan: unused!? */

	/* no Descriptors supported (yet) */
	/* no Descriptor handle support, so not possible to set an error */
	/* so return Invalid Handle */
	return SQL_INVALID_HANDLE;
}
