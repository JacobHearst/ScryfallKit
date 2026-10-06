#!/usr/bin/swift
//
//  check-all-cases.swift
//
//  Verifies that every `static let x = T(rawValue: ...)` declared on a RawRepresentable struct
//  is listed in that struct's `allCases` array (and vice versa).
//
//  Usage: swift Scripts/check-all-cases.swift [sources-directory]
//

import Foundation
import RegexBuilder

let root = CommandLine.arguments.dropFirst().first ?? "Sources"

/// An identifier, optionally wrapped in backticks (e.g. `class`)
let identifier = Regex {
    Optionally("`")
    OneOrMore(.word)
    Optionally("`")
}

func clean(_ name: Substring) -> String { name.replacingOccurrences(of: "`", with: "") }

/// `static let allCases: [Type] = [ ... ]`
let allCasesDeclaration = Regex {
    "static let allCases:"
    ZeroOrMore(.whitespace)
    "["
    Capture { OneOrMore(.word) }
    "]"
    ZeroOrMore(.whitespace)
    "="
    ZeroOrMore(.whitespace)
    "["
    Capture { ZeroOrMore(.any, .reluctant) }
    "]"
    ZeroOrMore(.horizontalWhitespace)
    One(.newlineSequence)
}

/// `.member` inside an allCases list
let listedMember = Regex {
    "."
    Capture { identifier }
}

/// `static let name = Type(rawValue:`
func declaredMember(of type: Substring) -> Regex<(Substring, Substring)> {
    Regex {
        "static let "
        Capture { identifier }
        ZeroOrMore(.whitespace)
        "="
        ZeroOrMore(.whitespace)
        type
        "(rawValue:"
    }
}

guard let enumerator = FileManager.default.enumerator(atPath: root) else {
    print("error: cannot read directory '\(root)'")
    exit(2)
}

var failures: [String] = []
var checked = 0

for case let path as String in enumerator where path.hasSuffix(".swift") {
    let file = "\(root)/\(path)"
    guard let source = try? String(contentsOfFile: file, encoding: .utf8) else { continue }

    for declaration in source.matches(of: allCasesDeclaration) {
        let (_, type, list) = declaration.output
        let listed = Set(list.matches(of: listedMember).map { clean($0.output.1) })
        let declared = Set(
            source.matches(of: declaredMember(of: type)).map { clean($0.output.1) })

        checked += 1
        let missing = declared.subtracting(listed).sorted()
        let extra = listed.subtracting(declared).sorted()
        if !missing.isEmpty {
            failures.append("\(file): \(type).allCases is missing: \(missing.joined(separator: ", "))")
        }
        if !extra.isEmpty {
            failures.append(
                "\(file): \(type).allCases lists unknown members: \(extra.joined(separator: ", "))")
        }
    }
}

if checked == 0 {
    print("error: found no allCases declarations under '\(root)'; is the path correct?")
    exit(2)
}

if failures.isEmpty {
    print("OK: checked allCases for \(checked) types")
} else {
    failures.forEach { print("error: \($0)") }
    exit(1)
}
