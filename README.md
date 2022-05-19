<img alt="logo" src="https://user-images.githubusercontent.com/140205/126669572-809c2700-7fcd-4177-9a9d-88721fddc21e.png">

[![Swift 5.4](https://img.shields.io/badge/Swift-5.4-orange)](https://swift.org/blog/swift-5-4-released/) [![SPM Compatible](https://img.shields.io/badge/SPM-Compatible-success)](https://swift.org/package-manager/) [![Swift](https://github.com/pkrll/deta-swift/actions/workflows/swift.yml/badge.svg)](https://github.com/pkrll/deta-swift/actions/workflows/swift.yml)

Deta-Swift is the unofficial Deta SDK for Swift.

:warning: This package is still under active development and things might and will change. Do not use this package as-is in a production app. :warning:

## Installation

To use ``Deta-Swift`` in your project, add the following line to your ``Package.swift`` file:

```swift
.package(url: "https://github.com/pkrll/deta-swift.git", from: "1.0.0")
```

Add the dependency to the targets that will use ``Deta-Swift``:

```swift
let package = Package(
    // ...
    dependencies: [
        .package(url: "https://github.com/pkrll/deta-swift.git", from: "1.0.0")
        // Other dependencies...
    ],
    targets: [
        .target(
            name: "<SomeApp>",
            dependencies: [
                .product(name: "Deta", package: "deta-swift")
                // Other dependencies...
            ]
        ),
        // Other targets...
    ]
)
```

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

The ``put`` method allows for adding multiple items to the Deta base in a single request. Your models must conform to the ``DetaModel`` protocol.

```swift
struct SomeModel: DetaModel {
    let key: String?
    let title: String
}

let items = [
    SomeModel(key: "1", title: "First item"),
    SomeModel(key: "2", title: "Second item")
]

let response = try await deta.put(items: items)
// response.processed contains all items that were successfully added.
// response.failed contains any item that failed due to internal processing.
```

For more information, please see the documentation for [Put Item](https://docs.deta.sh/docs/base/http/#put-item) on Deta Docs.

### Get Item

The ``get`` method retrieves a single item from the Deta base. This method requires a specific model type specified when retrieving. The return value must conform to your model, otherwise an error is returned.

If the item does not exist, an error will be returned.

```swift
struct SomeModel: DetaModel {
    let key: String?
    let title: String
}

let model = try await deta.get(model: SomeModel.self, key: "1")
```

For more information, please see the documentation for [Get Item](https://docs.deta.sh/docs/base/http/#get-item) on Deta Docs.

### Delete Item

The ``delete`` method deletes an item from the Deta base. Regardless of whether the item exists or not, a successful response will be returned.

```swift
try await deta.delete(key: "1")
```

For more information, please see the documentation for [Delete Item](https://docs.deta.sh/docs/base/http/#delete-item) on Deta Docs.

### Insert Item

The ``insert`` method inserts a single item into the Deta Base. If an item with the same key already exists, an error will be returned.

```swift
struct SomeModel: Fetchable {
    let key: String?
    let title: String
}

let itemToInsert = SomeModel(key: "1", title: "First item")
let insertedItem = try await deta.insert(itemToInsert)
```

For more information, please see the documentation for [Insert Item](https://docs.deta.sh/docs/base/http/#insert-item) on Deta Docs.

### Fetch Item

The ``fetch`` method retrieves items that matches some predicate. The predicate is a collection of `Query` objects. For more information on queries, please consult the [Deta docs](https://docs.deta.sh/docs/base/sdk/#queries).

``Deta-Swift`` has support for the following operators:

**Equals**:

```swift
Query(_: String, equals: AnyEncodable)
```

**Less Than**

```swift
Query(_: String, isLessThan: AnyEncodable)
Query(_: String, isLessThanOrEqualsTo: AnyEncodable)
```

**Greater than**

```swift
Query(_: String, isGreaterThan: AnyEncodable)
Query(_: String, isGreaterThanOrEqualsTo: AnyEncodable)
```

**Prefix**

```swift
Query(_: String, hasPrefix: AnyEncodable)
```

**Range**

```swift
Query(_: String, isBetween: ClosedRange<Int>)
Query(_: String, isBetween: ClosedRange<Double>)
```

**Contains**

```swift
Query(_: String, contains: AnyEncodable)
Query(_: String, doesNotContain: AnyEncodable)
```

`Query` objects can be grouped using `GroupedQueries`:

```swift
GroupedQueries {
    Query("someField", contains: "Some value")
    Query("someOtherField", isGreaterThan: 13)
}
```

Grouping queries are equivalent to ``OR``, while multiple groups of queries will be `AND`ed.

```swift
struct SomeModel: Fetchable {
    let key: String?
    let title: String
    let year: Int
}

// Fetch items that satisfies the following:
// - Title contains "some value" AND year equals to 1988, OR:
// - Year ranges between 2000 and 2010
let response1 = try await deta.fetch(model: SomeModel.self) {
    GroupedQueries {
        Query("title", contains: "Some value")
        Query("year", equals: "1988")
    }
    
    GroupedQueries {
        Query("year", isBetween: 2000...2010)
    }
}

// Fetch items that satisfies the following:
// - Title contains "some value" AND
// - Year is less than 1960
let response2 = try await deta.fetch(model: SomeModel.self) {
    Query("title", contains: "Some value")
    Query("year", isLessThan: 1960)
}
```

For more information, please see the documentation for [Query Item](https://docs.deta.sh/docs/base/http/#query-item) on Deta Docs.
