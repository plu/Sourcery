//
// Created by Krzysztof Zablocki on 13/09/2016.
// Copyright (c) 2016 Pixle. All rights reserved.
//
#if !canImport(ObjectiveC)
import Foundation
// For DynamicMemberLookup we need to import Stencil,
// however, this is different from SourceryRuntime.content.generated.swift, because
// it cannot reference Stencil
import Stencil

/// Defines enum case associated value
public final class AssociatedValue: NSObject, SourceryModel, AutoDescription, Typed, Annotated, Diffable, DynamicMemberLookup {
    public subscript(dynamicMember member: String) -> Any? {
        switch member {
            case "externalName":
                return externalName
            case "localName":
                return localName
            case "typeName":
                return typeName
            case "type":
                return type
            case "defaultValue":
                return defaultValue
            case "annotations":
                return annotations
            default:
                fatalError("unable to lookup: \(member) in \(self)")
        }
    }

    /// Associated value local name.
    /// This is a name to be used to construct enum case value
    public let localName: String?

    /// Associated value external name.
    /// This is a name to be used to access value in value-bindig
    public let externalName: String?

    /// Associated value type name
    public let typeName: TypeName

    // sourcery: skipEquality, skipDescription
    /// Associated value type, if known
    public var type: Type?

    /// Associated value default value
    public let defaultValue: String?

    /// Annotations, that were created with // sourcery: annotation1, other = "annotation value", alterantive = 2
    public var annotations: Annotations = [:]

    /// :nodoc:
    public init(localName: String?, externalName: String?, typeName: TypeName, type: Type? = nil, defaultValue: String? = nil, annotations: [String: NSObject] = [:]) {
        self.localName = localName
        self.externalName = externalName
        self.typeName = typeName
        self.type = type
        self.defaultValue = defaultValue
        self.annotations = annotations
    }

    convenience init(name: String? = nil, typeName: TypeName, type: Type? = nil, defaultValue: String? = nil, annotations: [String: NSObject] = [:]) {
        self.init(localName: name, externalName: name, typeName: typeName, type: type, defaultValue: defaultValue, annotations: annotations)
    }

    /// :nodoc:
    override public var description: String {
        var string = "\(Swift.type(of: self)): "
        string += "localName = \(String(describing: self.localName)), "
        string += "externalName = \(String(describing: self.externalName)), "
        string += "typeName = \(String(describing: self.typeName)), "
        string += "defaultValue = \(String(describing: self.defaultValue)), "
        string += "annotations = \(String(describing: self.annotations))"
        return string
    }

    public func diffAgainst(_ object: Any?) -> DiffableResult {
        let results = DiffableResult()
        guard let castObject = object as? AssociatedValue else {
            results.append("Incorrect type <expected: AssociatedValue, received: \(Swift.type(of: object))>")
            return results
        }
        results.append(contentsOf: DiffableResult(identifier: "localName").trackDifference(actual: self.localName, expected: castObject.localName))
        results.append(contentsOf: DiffableResult(identifier: "externalName").trackDifference(actual: self.externalName, expected: castObject.externalName))
        results.append(contentsOf: DiffableResult(identifier: "typeName").trackDifference(actual: self.typeName, expected: castObject.typeName))
        results.append(contentsOf: DiffableResult(identifier: "defaultValue").trackDifference(actual: self.defaultValue, expected: castObject.defaultValue))
        results.append(contentsOf: DiffableResult(identifier: "annotations").trackDifference(actual: self.annotations, expected: castObject.annotations))
        return results
    }

    public override var hash: Int {
        var hasher = Hasher()
        hasher.combine(self.localName)
        hasher.combine(self.externalName)
        hasher.combine(self.typeName)
        hasher.combine(self.defaultValue)
        hasher.combine(self.annotations)
        return hasher.finalize()
    }

    /// :nodoc:
    public override func isEqual(_ object: Any?) -> Bool {
        guard let rhs = object as? AssociatedValue else { return false }
        if self.localName != rhs.localName { return false }
        if self.externalName != rhs.externalName { return false }
        if self.typeName != rhs.typeName { return false }
        if self.defaultValue != rhs.defaultValue { return false }
        if self.annotations != rhs.annotations { return false }
        return true
    }

// sourcery:inline:AssociatedValue.AutoCoding

        /// :nodoc:
        required public init?(coder aDecoder: NSCoder) {
            self.localName = aDecoder.decode(forKey: "localName")
            self.externalName = aDecoder.decode(forKey: "externalName")
            guard let typeName: TypeName = aDecoder.decode(forKey: "typeName") else { 
                withVaList(["typeName"]) { arguments in
                    NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: arguments)
                }
                fatalError()
             }; self.typeName = typeName
            self.type = aDecoder.decode(forKey: "type")
            self.defaultValue = aDecoder.decode(forKey: "defaultValue")
            guard let annotations: Annotations = aDecoder.decode(forKey: "annotations") else { 
                withVaList(["annotations"]) { arguments in
                    NSException.raise(NSExceptionName.parseErrorException, format: "Key '%@' not found.", arguments: arguments)
                }
                fatalError()
             }; self.annotations = annotations
        }

        /// :nodoc:
        public func encode(with aCoder: NSCoder) {
            aCoder.encode(self.localName, forKey: "localName")
            aCoder.encode(self.externalName, forKey: "externalName")
            aCoder.encode(self.typeName, forKey: "typeName")
            aCoder.encode(self.type, forKey: "type")
            aCoder.encode(self.defaultValue, forKey: "defaultValue")
            aCoder.encode(self.annotations, forKey: "annotations")
        }
// sourcery:end

}
#endif
