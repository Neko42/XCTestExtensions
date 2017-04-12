//: Playground - noun: a place where people can play

import XCTest

extension XCTest
{
    public func XCTAssertEqualDictionaries<T, U>(_ expression1: [T : U], _ expression2: [T : U], _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) where T : Hashable, U : Any
    {
        let leftKeys = expression1.keys.sorted(by: {$0.0.hashValue > $0.1.hashValue})
        let rightKeys = expression2.keys.sorted(by: {$0.0.hashValue > $0.1.hashValue})
        
        XCTAssertEqual(leftKeys.count, rightKeys.count, "number of keys do not match")
        
        let leftKeyIterator = leftKeys.makeIterator()
        let rightKeyIterator = rightKeys.makeIterator()
        
        for (left, right) in zip(leftKeyIterator, rightKeyIterator)
        {
            print("will check that \(left) == \(right)")
            XCTAssertEqual(left, right)
            
            let leftValues = expression1[left]!
            let rightValues = expression2[right]!
            
            print("will check that \(leftValues) == \(rightValues)")
            
            if let leftDictionaries = leftValues as? [String:Any], let rightDictionaries = rightValues as? [String:Any]
            {
                print("will compare \(leftDictionaries) and \(rightDictionaries)")
                XCTAssertEqualDictionaries(leftDictionaries, rightDictionaries)
            }
                
            else if let leftString = leftValues as? String, let rightString = rightValues as? String
            {
                XCTAssertEqual(leftString, rightString)
            }
            else if let leftInt = leftValues as? Double, let rightInt = rightValues as? Double
            {
                XCTAssertEqual(leftInt, rightInt)
            }
            else if let leftInt = leftValues as? Int64, let rightInt = rightValues as? Int64
            {
                XCTAssertEqual(leftInt, rightInt)
            }
            else if let leftInt = leftValues as? [Int64], let rightInt = rightValues as? [Int64]
            {
                XCTAssertEqual(leftInt, rightInt)
            }
            else
            {
                XCTFail("Could not determine type for \(leftValues) or \(rightValues)")
            }
        }
    }
}

let a = ["hello" : 42]
let b = ["hello" : 42]
let c = ["hell" : 42]
let d = ["one" : 1, "two" : 2]
let nested = ["a" : a, "b" : b]
let sameAsNested = ["b" : a, "a" : b]

class Tester : XCTestCase
{
    func testFirst()
    {
        XCTAssertEqualDictionaries(a, c)
    }
    func testSecond()
    {
        XCTAssertEqualDictionaries(a, d)
    }
    
    func testShouldBeEqual()
    {
        XCTAssertEqualDictionaries(nested, sameAsNested)
    }
}

let testSuite = Tester.defaultTestSuite()
testSuite.run()



let timeInterval = TimeInterval(54.35)
let sameInInt = Int64(timeInterval)


