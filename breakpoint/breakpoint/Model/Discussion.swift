//
//  Discussion.swift
//  breakpoint
//
//  Created by Soufiane Salouf on 3/6/18.
//  Copyright © 2018 Soufiane Salouf. All rights reserved.
//

import Foundation

class Discussion {
    private var _discussionTitle: String
    private var _discussionDesc: String
    private var _key: String
    private var _memberCount: Int
    private var _members: [String]
    
    var discussionTitle: String {
        return _discussionTitle
    }
    
    var discussionDesc: String {
        return _discussionDesc
    }
    
    var Key: String {
        return _key
    }
    
    var memberCount: Int {
        return _memberCount
    }
    
    var members: [String] {
        return _members
    }
    
    init(title: String, description: String , key: String , members: [String] , memberCount: Int){
        self._discussionTitle = title
        self._members = members
        self._discussionDesc = description
        self._key = key
        self._memberCount = memberCount
    }
}
