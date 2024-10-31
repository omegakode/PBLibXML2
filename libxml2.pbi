;libxml2.pbi

CompilerIf #PB_Compiler_Processor = #PB_Processor_x86 Or #PB_Compiler_Processor = #PB_Processor_Arm32   
	Debug "Error, only X64 supported"
	End
CompilerEndIf

CompilerIf #PB_Compiler_OS = #PB_OS_Windows
	#LIBXML2_LIB_PATH = "lib\windows\x64\"

CompilerElseIf #PB_Compiler_OS = #PB_OS_Linux
	Debug "Error, only windows supported"
	End
CompilerElseIf #PB_Compiler_OS = #PB_OS_MacOS
	Debug "Error, only windows supported"
	End
CompilerEndIf

Import #LIBXML2_LIB_PATH + "libmsvcrt.a"
EndImport

ImportC #LIBXML2_LIB_PATH + "lzma.lib"
EndImport

ImportC #LIBXML2_LIB_PATH + "zlib.lib"
EndImport

ImportC #LIBXML2_LIB_PATH + "libxml2.lib"
	xmlInitParser.l()
	xmlParseFile.i(file.p-utf8)
	xmlFreeDoc.l(doc.i)
	xmlMemFree.l(v.i)
	
	xmlXPathNewContext.i(doc.i)
	xmlXPathFreeContext.l(xpCtx.i)
	xmlXPathFreeObject.l(xpObj.i)
	xmlXPathEvalExpression.i(xpathExpr.p-utf8, xpCtx.i)
	
	xmlNodeListGetString.i(doc.i, lst.i, inLine.i)
EndImport

;- Enum xmlXPathObjectType
Enumeration
	#XPATH_UNDEFINED = 0
	#XPATH_NODESET = 1
	#XPATH_BOOLEAN = 2
	#XPATH_NUMBER = 3
	#XPATH_STRING = 4
	#XPATH_POINT = 5
	#XPATH_RANGE = 6
	#XPATH_LOCATIONSET = 7
	#XPATH_USERS = 8
	#XPATH_XSLT_TREE = 9
EndEnumeration

;- Enum xmlElementType
Enumeration 
	#XML_ELEMENT_NODE = 1
	#XML_ATTRIBUTE_NODE = 2
	#XML_TEXT_NODE = 3
	#XML_CDATA_SECTION_NODE = 4
	#XML_ENTITY_REF_NODE = 5
	#XML_ENTITY_NODE = 6 
	#XML_PI_NODE = 7
	#XML_COMMENT_NODE = 8
	#XML_DOCUMENT_NODE = 9
	#XML_DOCUMENT_TYPE_NODE = 10 
	#XML_DOCUMENT_FRAG_NODE = 11
	#XML_NOTATION_NODE = 12 
	#XML_HTML_DOCUMENT_NODE = 13
	#XML_DTD_NODE = 14
	#XML_ELEMENT_DECL = 15
	#XML_ATTRIBUTE_DECL = 16
	#XML_ENTITY_DECL = 17
	#XML_NAMESPACE_DECL = 18
	#XML_XINCLUDE_START = 19
	#XML_XINCLUDE_END = 20 
EndEnumeration

;- Enum xmlAttributeType
Enumeration 
	#XML_ATTRIBUTE_CDATA = 1
	#XML_ATTRIBUTE_ID = 2
	#XML_ATTRIBUTE_IDREF = 3
	#XML_ATTRIBUTE_IDREFS = 4
	#XML_ATTRIBUTE_ENTITY = 5
	#XML_ATTRIBUTE_ENTITIES = 6
	#XML_ATTRIBUTE_NMTOKEN = 7
	#XML_ATTRIBUTE_NMTOKENS = 8
	#XML_ATTRIBUTE_ENUMERATION = 9
	#XML_ATTRIBUTE_NOTATION = 10
EndEnumeration

;- Enum xmlErrorLevel
Enumeration 
    #XML_ERR_NONE = 0
    #XML_ERR_WARNING = 1 
    #XML_ERR_ERROR = 2 
    #XML_ERR_FATAL = 3 
EndEnumeration

;- PROTOTYPES
PrototypeC.l xmlXPathConvertFunc(xoObj.i, type.l)
PrototypeC.i xmlXPathAxisFunc(ctxt.i, cur.i)
PrototypeC.i xmlXPathVariableLookupFunc(ctxt.i, name.i, ns_uri.i)
PrototypeC.i xmlXPathFuncLookupFunc(ctxt.i, name.i, ns_uri.i)
PrototypeC.l xmlXPathFunction(ctxt.i, nargs.l)
PrototypeC.l xmlStructuredErrorFunc(userData.i, error.i)

;- Struct xmlNodePtrArr_PB
Structure xmlNodePtrArr_PB
	*node.xmlNode[0]
EndStructure

;- Struct xmlXPathTypePtrArr_PB
Structure xmlXPathTypePtrArr_PB
	*xpathType.xmlXPathType[0]
EndStructure

;- Struct xmlXPathAxisPtrArr_PB
Structure xmlXPathAxisPtrArr_PB
	*xpathAxis.xmlXPathAxis[0]
EndStructure

;- Struct xmlNsPtrArr_PB
Structure xmlNsPtrArr_PB
	*ns.xmlNs[0]
EndStructure

;- Struct xmlXPathParserContext
Structure xmlXPathParserContext Align #PB_Structure_AlignC
	cur.i	
	base.i	
	error.l	
	*context.xmlXPathContext	
	*value.xmlXPathObject	
	valueNr.l	
	valueMax.l
	*valueTab.xmlXPathObject	
	comp.i
	xptr.l	
	*ancestor.xmlNode	
	valueFrame.l	
EndStructure

;- Struct xmlError
Structure xmlError Align #PB_Structure_AlignC
	domain.l	
	code.l	
	message.i	
	level.l
	file.i
	line.l
	str1.i
	str2.i	
	str3.i	
	int1.l
	int2.l
	ctxt.i	
	node.i	
EndStructure

;- Struct xmlDtd
Structure xmlDtd Align #PB_Structure_AlignC
	_private.i
	type.l
	name.i
	*children.xmlNode	
	*last.xmlNode	
	*parent.xmlDoc
	*next.xmlNode	
	*prev.xmlNode	
	*doc.xmlDoc	
	notations.i	
	elements.i	
	attributes.i	
	entities.i	
	ExternalID.i	
	SystemID.i	
	pentities.i	
EndStructure

;- Struct xmlDoc
Structure xmlDoc Align #PB_Structure_AlignC
	_private.i
	type.l
	name.i	
	*children.xmlNode	
	*last.xmlNode	
	*parent.xmlNode	
	*next.xmlNode	
	*prev.xmlNode	
	*doc.xmlDoc	
	level.l 
	standalone.l 
	*intSubset.xmlDtd	
	*extSubset.xmlDtd	
	*oldNs.xmlNs
	version.i	
	encoding.i
	ids.i	
	refs.i	
	URL.i	
	unused.l
	dict.i
	psvi.i	
	parseFlags.l	
	properties.l
EndStructure

;- Struct xmlXPathType
Structure xmlXPathType Align #PB_Structure_AlignC
	name.i
	func.xmlXPathConvertFunc
EndStructure

;- Struct xmlXPathAxis
Structure xmlXPathAxis Align #PB_Structure_AlignC
    name.i
    func.xmlXPathAxisFunc
EndStructure

;- Struct xmlXPathContext
Structure xmlXPathContext Align #PB_Structure_AlignC
	*doc.xmlDoc	
	*node.xmlNode	
	nb_variables_unused.l	
	max_variables_unused.l
	varHash.i	
	nb_types.l
	max_types.l	
	*types.xmlXPathTypePtrArr_PB
	nb_funcs_unused.l	
	max_funcs_unused.l
	funcHash.i
	nb_axis.l	
	max_axis.l
	*axis.xmlXPathAxisPtrArr_PB
	*namespaces.xmlNsPtrArr_PB
	nsNr.l
	user.i	
	contextSize.l	
	proximityPosition.l
	xptr.l	
	*here.xmlNode
	*origin.xmlNode	
	nsHash.i
	varLookupFunc.xmlXPathVariableLookupFunc
	varLookupData.i
	extra.i
	function.i
	functionURI.i	
	funcLookupFunc.xmlXPathFuncLookupFunc
	funcLookupData.i
	*tmpNsList.xmlNsPtrArr_PB
	tmpNsNr.l
	userData.i
	error.xmlStructuredErrorFunc
	lastError.xmlError
	*debugNode.xmlNode
	dict.i
	flags.l
	cache.i	
	opLimit.l
	opCount.l
	depth.l
EndStructure

;- Struct xmlID
Structure xmlID Align #PB_Structure_AlignC
    *next.xmlID
    value.i
    *attr.xmlAttr	
    name.i	
    lineno.l
    *doc.xmlDoc
EndStructure

;- Struct xmlAttr
Structure xmlAttr Align #PB_Structure_AlignC
    _private.i
    type.l
    name.i
    *children.xmlNode
    *last.xmlNode
    *parent.xmlNode
    *next.xmlAttr
    *prev.xmlAttr
    *doc.xmlDoc
    *ns.xmlNs
    atype.l
    psvi.i
    *id.xmlID	
EndStructure

;- Struct xmlNs
Structure xmlNs Align #PB_Structure_AlignC
    *next.xmlNs
    type.l
    href.i
    prefix.i
    _private.i
    *context.xmlDoc
EndStructure

;- Struct xmlNode
Structure xmlNode Align #PB_Structure_AlignC
	_private.i
	type.l
	name.i
	*children.xmlNode
	*last.xmlNode
	*parent.xmlNode	
	*next.xmlNode	
	*prev.xmlNode	
	*doc.xmlNode	
	*ns.xmlNs	
	content.i
	*properties.xmlAttr
	*nsDef.xmlNs
	psvi.i	
	line.w	
	extra.w
EndStructure

;- Struct xmlNodeSet
Structure xmlNodeSet Align #PB_Structure_AlignC
    nodeNr.l
    nodeMax.l
		*nodeTab.xmlNodePtrArr_PB
EndStructure

;- Struct xmlXPathObject
Structure xmlXPathObject Align #PB_Structure_AlignC
    type.l
    *nodesetval.xmlNodeSet
    boolval.l
    floatval.d
    stringval.i
    user.i
    index.l
    user2.i
    index2.l
EndStructure