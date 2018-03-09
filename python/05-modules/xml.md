# xml

```python
import xml.etree.ElementTree as ET
help(ET)
```

```python
fromstring = XML(text, parser=None)
    Parse XML document from string constant.

    This function can be used to embed "XML Literals" in Python code.

    *text* is a string containing XML data, *parser* is an
        optional parser instance, defaulting to the standard XMLParser.

    Returns an Element instance.

parse(source, parser=None)
    Parse XML document into element tree.

    *source* is a filename or file object containing XML data,
        *parser* is an optional parser instance defaulting to XMLParser.

    Return an ElementTree instance.
```

## xml.etree.ElementTree

```python
import xml.etree.ElementTree as ET

data = r'''<?xml version="1.0" encoding="UTF-8"?>
<metadata>
  <groupId>cn.xxx.xlsx</groupId>
  <artifactId>xlsx</artifactId>
  <versioning>
    <release>1.1.3</release>
    <versions>
      <version>1.0</version>
      <version>1.1</version>
      <version>1.1.1</version>
      <version>1.1.2</version>
      <version>1.1.3</version>
    </versions>
    <lastUpdated>20170120083155</lastUpdated>
  </versioning>
</metadata>
'''

root = ET.fromstring(data)
for node in root.iter('version'):
    print(node,node.text)

r = ET.parse('xmltest.xml')
for node1 in root.iter('version'):
    print(node1,node1.text)
```

## xml.parsers.expat(难用)

```python
import requests
from xml.parsers.expat import ParserCreate



class AppHandle(object):

    def __init__(self):
        self.now_tag = ''
        self.version = []

    def start_element(self, tag, attrs):
        self.now_tag = tag

    def version_data(self, version):
        if self.now_tag == 'version':
            if version.strip() != '':
                self.version.append(version)

    def end_element(self,name):
        pass


data = r'''<?xml version="1.0" encoding="UTF-8"?>
<metadata>
  <groupId>cn.xxx.xlsx</groupId>
  <artifactId>xlsx</artifactId>
  <versioning>
    <release>1.1.3</release>
    <versions>
      <version>1.0</version>
      <version>1.1</version>
      <version>1.1.1</version>
      <version>1.1.2</version>
      <version>1.1.3</version>
    </versions>
    <lastUpdated>20170120083155</lastUpdated>
  </versioning>
</metadata>
'''

handler = AppHandle()
parser = ParserCreate()
parser.StartElementHandler = handler.start_element
parser.EndElementHandler = handler.end_element
parser.CharacterDataHandler = handler.version_data
parser.Parse(data)
print(handler.version)
```