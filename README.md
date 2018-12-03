# POCompanion
Swift library to communicate with poeditor.com **API v2**. By default download files from all languages in your project.

### Usage

```swift
let poc = POCompanion(token: <# API Token #>, projectID: <# ProjectID #>)
poc.fetch { (languages, error) in
	// If error == nil, everything went ok. Language files in apple-strings format is available in Language object
	
}
```

To get language file as `Data` use `fetch` to download in all available languages and then:

```swift
language.fileData
```

contains encoded file using `utf8`