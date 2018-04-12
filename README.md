# tool_extract_localized_strings_from_4rp
Genero includes tools for extracting the string-identifiers for a localized string file from the application source and form definition files. At this time, however, no tool exists for extracting string-identifiers from a report definition file (.4rp) - see GST-08839. 

This application,  created by Keith Y and posted to the Four Js Forum, extracts the string-identifiers from specified .4rp files.

For a future update: For completeness I would like to point out that there might be other character entities besides "&amp;" that need to be taken care of such as &lt;, &gt;, &quot; or &apos;. Using an XML reader instead of a channel would solve this issue.
