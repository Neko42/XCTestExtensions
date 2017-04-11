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
            XCTAssertEqual(left, right)
        }
        
        let leftValuesIterator = expression1.values.makeIterator()
        let rightValuesIterator = expression2.values.makeIterator()
        
        for (left, right) in zip(leftValuesIterator, rightValuesIterator)
        {
            if let leftDictionaries = left as? [String:Any], let rightDictionaries = right as? [String:Any]
            {
                XCTAssertEqualDictionaries(leftDictionaries, rightDictionaries)
            }
            
            if let leftString = left as? String, let rightString = right as? String
            {
                XCTAssertEqual(leftString, rightString)
            }
            if let leftInt = left as? Int, let rightInt = right as? Int
            {
                XCTAssertEqual(leftInt, rightInt)
            }
            //Add your own types to test here
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
