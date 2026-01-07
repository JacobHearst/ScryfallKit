//
// CaseIterableTests.swift
//

import XCTest
import ScryfallKit

/// A test suite to remind maintainers to make sure that all the known cases for
/// an enum's `allCases` property.
///
/// Some of the enums in ScryfallKit have to get updated a lot because WOTC
/// is constantly playing with card design. To fill the gap between the release
/// of a new enum case and the release of a supporting ScryfallKit version,
/// the `unknown(String)` case was introduced.
///
/// Unfortunately, adding an associated value to an enum prevents the compiler
/// from automatically synthesizing the `CaseIterable` conformance.
///
/// The manual conformance of `CaseIterable` for the affected types MUST include all cases
/// _except_ the `unknown(String)` case. Manually providing this conformance introduces the
/// risk that a new case will be added to one of these types but NOT added to the `allCases`
/// array. This test suite aims to prevent that via (ab)use of switch exhaustivity. By switching
/// on an arbitrary enum case in a unit test, the compiler will error out if a new case is added
/// to the enum but not added to the switch statement in the test. This should hopefully
/// remind maintainers to keep `allCases` up to date.
///
/// ##################################################
/// # IF THESE TESTS ARE FAILING:
/// You probably added a new case to one of the enums under test. This is your
/// reminder to **make sure** that you added the new case to that enum's `allCases`
/// array. Once you've done so, add your new case to this switch statement.
/// ##################################################
final class CaseIterableTests: XCTestCase {
  func testFrameEffect() {
    let stub = Card.FrameEffect.battle
    let contains = switch stub {
    case .legendary: Card.FrameEffect.allCases.contains(stub)
    case .miracle: Card.FrameEffect.allCases.contains(stub)
    case .nyxTouched: Card.FrameEffect.allCases.contains(stub)
    case .draft: Card.FrameEffect.allCases.contains(stub)
    case .devoid: Card.FrameEffect.allCases.contains(stub)
    case .tombstone: Card.FrameEffect.allCases.contains(stub)
    case .colorShifted: Card.FrameEffect.allCases.contains(stub)
    case .inverted: Card.FrameEffect.allCases.contains(stub)
    case .sunMoonDfc: Card.FrameEffect.allCases.contains(stub)
    case .compassLandDfc: Card.FrameEffect.allCases.contains(stub)
    case .originPwDfc: Card.FrameEffect.allCases.contains(stub)
    case .moonEldraziDfc: Card.FrameEffect.allCases.contains(stub)
    case .waxingAndWaningMoonDfc: Card.FrameEffect.allCases.contains(stub)
    case .showcase: Card.FrameEffect.allCases.contains(stub)
    case .extendedArt: Card.FrameEffect.allCases.contains(stub)
    case .companion: Card.FrameEffect.allCases.contains(stub)
    case .etched: Card.FrameEffect.allCases.contains(stub)
    case .snow: Card.FrameEffect.allCases.contains(stub)
    case .lesson: Card.FrameEffect.allCases.contains(stub)
    case .convertDfc: Card.FrameEffect.allCases.contains(stub)
    case .fAndFc: Card.FrameEffect.allCases.contains(stub)
    case .battle: Card.FrameEffect.allCases.contains(stub)
    case .gravestone: Card.FrameEffect.allCases.contains(stub)
    case .fullArt: Card.FrameEffect.allCases.contains(stub)
    case .vehicle: Card.FrameEffect.allCases.contains(stub)
    case .borderless: Card.FrameEffect.allCases.contains(stub)
    case .extended: Card.FrameEffect.allCases.contains(stub)
    case .spree: Card.FrameEffect.allCases.contains(stub)
    case .textless: Card.FrameEffect.allCases.contains(stub)
    case .enchantment: Card.FrameEffect.allCases.contains(stub)
    case .shatteredGlass: Card.FrameEffect.allCases.contains(stub)
    case .upsideDownDfc: Card.FrameEffect.allCases.contains(stub)
    case .unknown(let string):
      // Unknown case shouldn't be in allCases
      !Card.FrameEffect.allCases.contains(.unknown(string))
    }

    XCTAssertTrue(contains)
  }

  func testLayout() {
    let stub = Card.Layout.adventure
    let contains = switch stub {
    case .normal: Card.Layout.allCases.contains(.normal)
    case .split: Card.Layout.allCases.contains(.split)
    case .flip: Card.Layout.allCases.contains(.flip)
    case .transform: Card.Layout.allCases.contains(.transform)
    case .meld: Card.Layout.allCases.contains(.meld)
    case .leveler: Card.Layout.allCases.contains(.leveler)
    case .saga: Card.Layout.allCases.contains(.saga)
    case .adventure: Card.Layout.allCases.contains(.adventure)
    case .planar: Card.Layout.allCases.contains(.planar)
    case .scheme: Card.Layout.allCases.contains(.scheme)
    case .vanguard: Card.Layout.allCases.contains(.vanguard)
    case .token: Card.Layout.allCases.contains(.token)
    case .emblem: Card.Layout.allCases.contains(.emblem)
    case .augment: Card.Layout.allCases.contains(.augment)
    case .host: Card.Layout.allCases.contains(.host)
    case .class: Card.Layout.allCases.contains(.class)
    case .battle: Card.Layout.allCases.contains(.battle)
    case .case: Card.Layout.allCases.contains(.case)
    case .mutate: Card.Layout.allCases.contains(.mutate)
    case .prototype: Card.Layout.allCases.contains(.prototype)
    case .modalDfc: Card.Layout.allCases.contains(.modalDfc)
    case .doubleSided: Card.Layout.allCases.contains(.doubleSided)
    case .doubleFacedToken: Card.Layout.allCases.contains(.doubleFacedToken)
    case .artSeries: Card.Layout.allCases.contains(.artSeries)
    case .reversibleCard: Card.Layout.allCases.contains(.reversibleCard)
    case .unknown(let string):
      // Unknown case shouldn't be in allCases
      !Card.Layout.allCases.contains(.unknown(string))
    }

    XCTAssertTrue(contains)
  }

  func testSetType() {
    let stub = MTGSet.Kind.funny
    let contains = switch stub {
    case .core: MTGSet.Kind.allCases.contains(.core)
    case .expansion: MTGSet.Kind.allCases.contains(.expansion)
    case .masters: MTGSet.Kind.allCases.contains(.masters)
    case .masterpiece: MTGSet.Kind.allCases.contains(.masterpiece)
    case .spellbook: MTGSet.Kind.allCases.contains(.spellbook)
    case .commander: MTGSet.Kind.allCases.contains(.commander)
    case .planechase: MTGSet.Kind.allCases.contains(.planechase)
    case .archenemy: MTGSet.Kind.allCases.contains(.archenemy)
    case .vanguard: MTGSet.Kind.allCases.contains(.vanguard)
    case .funny: MTGSet.Kind.allCases.contains(.funny)
    case .starter: MTGSet.Kind.allCases.contains(.starter)
    case .box: MTGSet.Kind.allCases.contains(.box)
    case .promo: MTGSet.Kind.allCases.contains(.promo)
    case .token: MTGSet.Kind.allCases.contains(.token)
    case .memorabilia: MTGSet.Kind.allCases.contains(.memorabilia)
    case .arsenal: MTGSet.Kind.allCases.contains(.arsenal)
    case .alchemy: MTGSet.Kind.allCases.contains(.alchemy)
    case .minigame: MTGSet.Kind.allCases.contains(.minigame)
    case .fromTheVault: MTGSet.Kind.allCases.contains(.fromTheVault)
    case .premiumDeck: MTGSet.Kind.allCases.contains(.premiumDeck)
    case .duelDeck: MTGSet.Kind.allCases.contains(.duelDeck)
    case .draftInnovation: MTGSet.Kind.allCases.contains(.draftInnovation)
    case .treasureChest: MTGSet.Kind.allCases.contains(.treasureChest)
    case .unknown(let string):
      // Unknown case shouldn't be in allCases
      !MTGSet.Kind.allCases.contains(.unknown(string))
    }

    XCTAssertTrue(contains)
  }
}
