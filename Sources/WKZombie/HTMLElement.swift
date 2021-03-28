//
// HTMLElement.swift
//
// Copyright (c) 2015 Mathias Koehnke (http://www.mathiaskoehnke.de)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

/// The HTMLElement class is a base class, which can represent every element 
/// in the DOM, e.g. "img", "a", "form" etc.

import Fuzi

public protocol HTMLElement : AnyObject, CustomStringConvertible {
    var element : XMLElement? { get }
    var XPathQuery : String? { get }
    var attributes : [ String : String ] { get }
    
    init(element: XMLElement)
    init(element: XMLElement, XPathQuery: String?)
}

extension HTMLElement {
    internal static func createXPathQuery(_ parameters: String) -> String {
        return "//*\(parameters)"
    }
    
    internal func createSetAttributeCommand(_ key : String, value: String?) -> String? {
        if let query = XPathQuery {
            return "getElementByXpath(\"\(query)\").setAttribute(\"\(key)\", \"\(value ?? "")\");"
        }
        return nil
    }
}

extension HTMLElement {
    public var text : String? {
        return element?.stringValue
    }
    
    public var tagName : String? {
        return element?.tag
    }
    
    public func objectForKey(_ key: String) -> String? {
        return element?.attributes[key.lowercased()]
    }
    
    public func childrenWithTagName<T: HTMLElement>(_ tagName: String) -> [T]? {
        return element?.children(tag: tagName).compactMap { T(element: $0) }
    }
    
    public func children() -> [HTMLParserElement]? {
        return children(as: HTMLParserElement.self)
    }
    
    public func children<T: HTMLElement>(as HTMLElementType: T.Type) -> [T]? {
        return element?.children.compactMap { T(element: $0) }
    }
    
    public func hasChildren() -> Bool {
        if let _ = self.element?.firstChild(css: "") {
            return true
        }
        return false
    }
    
    public var description : String {
        return element?.description ?? ""
    }
}
