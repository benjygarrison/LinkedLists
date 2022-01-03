//
//  main.swift
//  LinkedLists
//
//  Created by Ben Garrison on 1/2/22.
//

import Foundation
/*
 linked lists are super fast at loading to the front and take up little space (shrink and grow dynamically), compared to arrays
 used in stacks and queues
 O(1) vs array O(n)!
 disadvantage: no random access, get/set = O(n)
 like a train [(Head)|"A"]--[(Node(s))|"Linked"]--[(Tail)|"List"]--> nil
 
 MARK: know for interview!!
 Anything on the front = O(1) -> addFront/getFirst/deleteFirst
 If you have to walk = O(n) -> addBack/getBack/deleteLast
 Always the right size
 No random access
 */




//MARK: Create Linked List:

class Node {
    var data: Int
    var next: Node?
    
    init(_ data: Int, _ next: Node? = nil) {
        self.data = data
        self.next = next
    }
}

//MARK: Functions to add/delete/search, etc.

class LinkedList {
    private var head: Node?
    
    func addFront(_ data: Int) { // O(1)
        let newNode = Node(data)
        newNode.next = head
        head = newNode
    }
    
    func getFirst() -> Int? { // O(1)
        if head == nil {
            return nil
        }
        return head!.data
    }
    
    func addBack(_ data: Int) { // O(n)
        let newNode = Node(data)
        
        if head == nil {
            head = newNode
            return
        }
        
        var node = head!
        while(node.next != nil) {
            node = node.next!
        }
        node.next = newNode
    }
    
    func getLast() -> Int? { // O(n)
        if head == nil {
            return nil
        }
        
        var node = head!
        while(node.next != nil) {
            node = node.next!
        }
        return node.data
    }
    
    func insert(position: Int, data: Int) { // O(n)
        if position == 0 {
            addFront(data)
            return
        }
        
        let newNode = Node(data)
        var currentNode = head
        for _ in 0..<position - 1 {
            currentNode = currentNode?.next
        }
        newNode.next = currentNode?.next
        currentNode?.next = newNode
    }
    
    func deleteFirst() { // O(1)
        head = head?.next
    }
    
    func deleteLast() { // O(n)
        var nextNode = head
        var previousNode: Node?
        
        while(nextNode?.next != nil) {
            previousNode = nextNode
            nextNode = nextNode?.next
        }
        previousNode?.next = nil
    }
    
    func delete(at position: Int) {
        if position == 0 {
            self.deleteFirst()
            return
        }
        
        var nextNode = head
        var previousNode: Node?
        for _ in 0..<position {
            previousNode = nextNode
            nextNode = nextNode?.next
        }
        previousNode?.next = nextNode?.next
    }
    
    var isEmpty: Bool {
        if head != nil {
            return false
        }
        return true
    }
    
    func clear() {
        head = nil
    }


//MARK: Function to print linked list as array:

func printLinkedList() {
        if head == nil {
            return
        }
    
        var result = [Int]()
        var node = head
        result.append(node!.data)
    
        while node?.next != nil {
            result.append(node!.next!.data)
            node = node?.next
        }
        print(result)
    }
}

//test functions

let linkedList = LinkedList()

linkedList.addFront(3)
linkedList.addFront(2)
linkedList.addFront(1)
linkedList.addFront(4)
linkedList.addBack(5)

linkedList.printLinkedList()




//MARK: ----- Algos start here! -----




//MARK: Question 1: write a funtion to return length of any linked list

func listLength(_ head: Node?) -> Int { // O(n)
    if head == nil {
      return 0
    }
    
    var length = 0
    var currentNode = head
    while currentNode != nil {
        length += 1
        currentNode = currentNode?.next
    }
    return length
}
//Note: this is wasteful (O(n)) in a real world setting. Just add a size function to the original function that tracks list length at all times as it grows/shrinks, and call that size function




/* MARK: Question 2: Merge 2 linked lists.
 
 Given pointers to the head nodes of 2 linked lists that merge together at some point, find the node where the two lists merge. The merge point is where both lists point to the same node, i.e. they reference the same memory location. It is guaranteed that the 2 nodes will be different, and neither will ne NULL. If the lists share a common node, return that node's value.
 After the merge point, both lists will share the same node pointers.
 Visualize by imagining 2 train lines, and the first section at which they overlap, i.e. MacArthur Station for Richmond/Pittsburg lines
 
 */

//Brute force O(n^2):
func findMergeFirstSolution(headA: Node?, headB: Node?) -> Int? { // O(m*n) -> O(n^2)
    let lengthOfA = listLength(headA) // O(m)
    let lengthOfB = listLength(headB) // O(n)
    
    var currentLengthOfA = headA
    
    for _ in 0...lengthOfA-1 { //O(m)
        var currentLengthOfB = headB
        for _ in 0...lengthOfB-1 { //O(n)
        let A = currentLengthOfA?.data
        let B = currentLengthOfB?.data
        //print("A: \(A ?? 0) B: \(B ?? 0)")
            if A == B {
                return A
            }
        currentLengthOfB = currentLengthOfB?.next
        }
        currentLengthOfA = currentLengthOfA?.next
    }
    return nil
}

//Trade time for space using a Dictionary:
func findMergeSecondSolution(headA: Node?, headB: Node?) -> Int? { //reduces to O(n)
    let lengthA = listLength(headA) // O(m)
    let lengthB = listLength(headB) // O(n)
    
    var dictionary = [Int?: Bool]()
    var currentB = headB
    
    for _ in 0...lengthB - 1 { // O(n)
        let B = currentB?.data
        dictionary[B] = true
        currentB = currentB?.next
    }
    
    var currentA = headA
    
    for _ in 0...lengthA - 1 { // O(m)
        let A = currentA?.data
        if dictionary[A] == true {
            return A
        }
        currentA = currentA?.next
    }
    return nil
}

//Compare lengths of lists and use the difference to find answer
func findMergeThirdSolution(headA: Node?, headB: Node?) -> Int? { // O(n)
    let lengthA = listLength(headA)
    let lengthB = listLength(headB)
    
    var currentA = headA
    var currentB = headB
    
    if lengthB > lengthA { //swap variables if lengthB is longer
        let temp = currentA
        currentA = currentB
        currentB = temp
    }
    
    let difference = abs(lengthA - lengthB) //could return negative, so make it absolute -> "abs()"
    
    for _ in 1...difference {
        currentA = currentA?.next
    }
    
    for _ in 0...lengthB-1 {
        let A = currentA?.data
        let B = currentB?.data
        if  A == B {
            return A
        }
        currentA = currentA?.next
        currentB = currentB?.next
    }
    
    return nil
}

/*MARK: question 3 detect a cycle
 
 https://www.hackerrank.com/challenges/ctci-linked-list-cycle/problem
 https://en.wikipedia.org/wiki/Cycle_detection#Floyd's_Tortoise_and_Hare
 
 A linked list is said to contain a cycle if any node is visited more than once while traversing the list. For example, in the following graph, there is a cycle formed when node 5 points back to node 3.
        4
      /   \
 1 2 3     5
     \_____/
        ^
        |
(This is bad, as it leaks memory when 5 and 3 keep pointing at each other indefinitely.)
*/

class CycleNode {
    var data: Int
    weak var next: CycleNode?
    
    init(_ data: Int, _ next: CycleNode? = nil) {
        self.data = data
        self.next = next
    }
}


func hasCycle(first: CycleNode) -> Bool {
    var slow: CycleNode? = first //tortoise
    var fast: CycleNode? = first //hare
    
    while fast != nil && fast!.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
        
        if slow?.data == fast?.data {
            return true
        }
    }
    
    
    return false
}


//MARK: Arguments and results:

//Args:

//For 1 and 2
let node6 = Node(6)
let node5 = Node(5, node6)
let node4 = Node(4, node5)
let node3 = Node(3, node4)
let node2 = Node(2, node3)
let node1 = Node(1, node2)

let node11 = Node(11, node4)
let node10 = Node(10, node11)

//For 3
let cycleNode5 = CycleNode(5)
let cycleNode4 = CycleNode(4)
let cycleNode3 = CycleNode(3)
let cycleNode2 = CycleNode(2)
let cycleHead = CycleNode(1)

cycleHead.next = cycleNode2
cycleNode2.next = cycleNode3
cycleNode3.next = cycleNode4
cycleNode4.next = cycleNode5
cycleNode5.next = cycleNode3

//Results:

print("")
print("Question 1 answer is: \(listLength(node3))")
print("")
print("Question 2 answer (brute force) is: \(findMergeFirstSolution(headA: node1, headB: node11) ?? 0)")
print("Question 2 answer (dictionary) is: \(findMergeFirstSolution(headA: node1, headB: node11) ?? 0)")
print("Question 2 answer (comparing lengths) is: \(findMergeFirstSolution(headA: node1, headB: node11) ?? 0)")
print("")
print("Question 4 answer is: \(hasCycle(first: cycleHead))")
print("")
