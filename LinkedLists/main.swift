//
//  main.swift
//  LinkedLists
//
//  Created by Ben Garrison on 1/2/22.
//

import Foundation

//MARK: Linked List algos:

/*
 linked lists are super fast at loading to the front and take up little space (shrink and grow dynamically), compared to arrays
 
 used in stacks and queues
 
 O(1) vs array O(n)!
 
 disadvantage: no random access, get/set = O(n)
 
 like a train [(Head)|"A"]--[(Node(s))|"Linked"]--[(Tail)|"List"]--> nil
 */

//MARK: know for interview!!

/*
 Anything on the front = O(1)
    - addFront/getFirst/deleteFirst
 
 If you have to walk = O(n)
    - addBack/getBack/deleteLast
 
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

let linkedList = LinkedList()

linkedList.addFront(3)
linkedList.addFront(2)
linkedList.addFront(1)
linkedList.addFront(4)
linkedList.addBack(5)

linkedList.printLinkedList()





