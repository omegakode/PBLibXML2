;xpathTest.pb

EnableExplicit

IncludeFile "libxml2.pbi"

Procedure main()
	Protected.xmlXPathContext *xpCtx
	Protected.xmlDoc *doc
	Protected.s xml, xp
	Protected.xmlXPathObject *xpObj
	Protected.l i, sz
	Protected.xmlNodeSet *nodeSet
	Protected.xmlNode *node
	Protected.i attVal
	Protected.xmlAttr *attr
	
	xmlInitParser()
	
	xml = "test3.xml"
	*doc = xmlParseFile(xml)
	If *doc = 0 : ProcedureReturn : EndIf 
	
	*xpCtx = xmlXPathNewContext(*doc)
	If *xpCtx = 0 : ProcedureReturn : EndIf 

	xp = "//child2"
	*xpObj = xmlXPathEvalExpression(xp, *xpCtx)
	If *xpObj = 0 : ProcedureReturn : EndIf 

	*nodeSet = *xpObj\nodesetval
	If *nodeSet = 0 : ProcedureReturn : EndIf 

	sz = *nodeSet\nodeNr	
	For i = 0 To sz - 1
		*node = *nodeSet\nodeTab\node[i]
		
		If *node\type = #XML_ELEMENT_NODE
			If *node\name
				Debug PeekS(*node\name, -1, #PB_UTF8)
			EndIf
			
			;Attributes
			*attr = *node\properties
			While *attr
				Debug "Attr:"
				If *attr\name
					Debug PeekS(*attr\name, -1, #PB_UTF8)
				EndIf
				
				attVal = xmlNodeListGetString(*node\doc, *attr\children, 1)
				If attVal
					Debug PeekS(attVal, -1, #PB_UTF8)
					xmlMemFree(attVal)
				EndIf
				
				*attr = *attr\next
			Wend 
		Else
		
		EndIf
	Next 
	
	xmlXPathFreeObject(*xpObj);
	xmlXPathFreeContext(*xpCtx); 
	xmlFreeDoc(*doc)
EndProcedure

main()
