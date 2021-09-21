%dw 2.0

/* this will replace the multiple character, or partial string, with a single instance of that character. Example replace 'xxxxx' with 'x' */
fun replaceDuplicatedCharacters(s,char) = (s default '') replace (('(' ++ char ++ ')+') as Regex) with char
	
/* remove characters not supported by Custom Metrics dimensions */	
fun removeMetricDimensionUnsupportedCharacters(s) = replaceDuplicatedCharacters(((s default '') replace /([^a-zA-Z0-9-_:.\/])/ with '_'),'_')

var businessGroupName = removeMetricDimensionUnsupportedCharacters(payload.businessGroup as String)

---

businessGroupName

