<img alt="logo" src="https://user-images.githubusercontent.com/140205/126669572-809c2700-7fcd-4177-9a9d-88721fddc21e.png">

![Swift 5.4](https://img.shields.io/badge/Swift-5.4-orange) ![SPM Compatible](https://img.shields.io/badge/SPM-Compatible-success)

Deta-Swift is the unofficial Deta SDK for Swift.

:warning: Still under development.

## Installation

Simply add ``.package(url: "https://github.com/pkrll/deta-swift.git", from: "1.0.0")`` to your dependencies in ``Package.swift`` .

## Usage

To start using Deta, you need to first retrieve your project key. Initialize the Deta object with your project key, and the name of your Deta base:

```swift
import Deta

let deta = Deta(projectKey: "YourProjectKey", base: "SampleDB")
```

The Deta SDK for Swift supports all of Deta's HTTP API endpoints currently available.

#### :warning: Warning :warning:

**Remember that your project key is a secret. Anyone with the key can access and modify your database. This SDK is not meant to be used client side, as it requires the API key to be sent over HTTPs and therefore visible for everyone. Do not commit this key to a public repository.**

### Put Item

The ``put`` method allows for adding multiple items to the Deta base in a single request. Your models must conform to the ``Fetchable`` protocol.

```swift
struct SomeModel: Fetchable {
    let key: String?
    let title: String
}

let items = [
    SomeModel(key: "1", title: "First item"),
    SomeModel(key: "2", title: "Second item")
]

deta.put(items: items) { result
    switch result {
    case .failure(let error):
        print(error)
    case .success(let response):
        // response.processed contains all items that were successfully added.
        // response.failed contains any item that failed due to internal processing.
    }
}
```

For more information, please see the documentation for [Put Item](https://docs.deta.sh/docs/base/http/#put-item) on Deta Docs.

### Get Item

The ``get`` method retrieves a single item from the Deta base. This method requires a specific model type specified when retrieving. The return value must conform to your model, otherwise an error is returned.

If the item does not exist, an error will be returned.

```swift
struct SomeModel: Fetchable {
    let key: String?
    let title: String
}

deta.get(key: "1", for: SomeModel.self) { result
    switch result {
    case .failure(let error):
        print(error)
    case .success(let response):
        // The response, as a SomeModel
    }
}
```

For more information, please see the documentation for [Get Item](https://docs.deta.sh/docs/base/http/#get-item) on Deta Docs.

### Delete Item

The ``delete`` method deletes an item from the Deta base. Regardless of whether the item exists or not, a successful response will be returned.

```swift
deta.delete(key: "1") { result
    switch result {
    case .failure(let error):
        print(error)
    case .success:
        // The item was or was not deleted 🤷🏻‍♂️
    }
}
```

For more information, please see the documentation for [Delete Item](https://docs.deta.sh/docs/base/http/#delete-item) on Deta Docs.

### Insert Item

The ``insert`` method inserts a single item into the Deta Base. If an item with the same key already exists, an error will be returned.

```swift
struct SomeModel: Fetchable {
    let key: String?
    let title: String
}

let item = SomeModel(key: "1", title: "First item")

deta.insert(item) { result
    switch result {
    case .failure(let error):
        print(error)
    case .success(let response):
        // The item inserted, as SomeModel
    }
}
```

For more information, please see the documentation for [Insert Item](https://docs.deta.sh/docs/base/http/#insert-item) on Deta Docs.

### Update Item

The ``update`` method updates an item based on a specified set of rules. If the key does not exist, an error is returned.

```swift
let request = Update.Request(
    set: [
        "title": "Hello World!",
        "link": "deta.sh"
    ],
    increment: ["numberOfReleases": 1]
)

deta.update(key: "1", payload: request) { result in
    switch result {
    case .failure(let error):
        print(error)
    case .success(let response):
        // The response will be identical to the Update.Request payload
    }
}
```

The ``Update.Request`` payload may have the following fields:

```swift
Update.Request(
    set: ["fieldName": Any], // The attributes to be updated or created.
    increment: ["fieldName": Int], // The attributes to be incremented. Increment value can be negative.
    append: ["fieldName": [Any]], // The attributes to append a value to. Appended value must be a list.
    prepend: ["fieldName": [Any]], // The attributes to prepend a value to. Prepended value must be a list.
    delete: [String] // The attributes to be deleted.
)
```

For more information, please see the documentation for [Update Item](https://docs.deta.sh/docs/base/http/#update-item) on Deta Docs.

### Fetch Item

The ``fetch`` method retrieves items that matches the specified query. A query is a list of dictionaries with a string key and AnyEncodable values. For more information on how to build a query, please consult the (Deta docs)[https://docs.deta.sh/docs/base/sdk/#queries].

```swift
struct SomeModel: Fetchable {
    let key: String?
    let title: String
    let timestamp: Int
}

let query: [[String: AnyEncodable]] = [
    ["title": "Deta", "timestamp?gt": 1620770000]
]

let request = Fetch.Request(query: query)

deta.fetch(model: SomeModel.self, query: request) { result in
    switch result {
    case .failure(let error):
        print(error)
    case .success(let response):
        // List of item fetched, as SomeModel
    }
}
```

For more information, please see the documentation for [Query Item](https://docs.deta.sh/docs/base/http/#query-item) on Deta Docs.
