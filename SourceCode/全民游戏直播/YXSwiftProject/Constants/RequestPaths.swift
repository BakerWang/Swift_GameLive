//
//  RequestPaths.swift
//  YXSwiftProject
//
//  Created by jiyingxin on 16/3/17.
//  Copyright © 2016年 jiyingxin. All rights reserved.
//

import Foundation

struct RequestPathManager {
    static private let basePath = "http://www.quanmin.tv/"
    
    enum RequestPath {
        case rooms          //直播房间列表
        case categories     //直播栏目类型列表
        case roomDetail     //获取房间详细信息
        case categoryRooms  //某栏目房间列表
        case video          //直播视频的网址
        case intro          //推荐页面
        case ad             //推荐页广告
        case search         //搜索功能
    }
    
    static func giveMeFullPath(requestPath :RequestPath, other:(page: Int?, _ : String?)) -> String! {

        var path: String = ""
    
        let page = other.page == nil ? "" : "\(other.page!)"
        
        switch requestPath {
        case .categories:
            path = "json/categories/list.json"
        case .ad:
            path = "json/page/ad-slot/info.json"
        case .categoryRooms:
//            guard other.1 == nil else {
//                assert(false, "\(self, #function) other.1 参数不能为nil")
//            }
            
            if other.1 == nil {
                showNilWarning("\(self, #function)")
            }else{
                path = "json/categories/\(other.1!)/list.json"
            }
            
            
        case .intro:
            path = "json/page/app-index/info.json"
        case .search:
            path = "api/v1"
        case .roomDetail:
            path = "json/rooms/\(page)/info.json"
        case .rooms:
            path = "json/play/list\(page).json"
        case .video:
//            guard other.1 == nil else {
//                assert(false, "\(self ,#function) other.1 参数不能为nil")
//            }
            if other.1 == nil {
                showNilWarning("\(self, #function)")
            }else{
                path = "http://hls.quanmin.tv/live/\(other.1!)/playlist.m3u8"
            }
            
        }
        return self.basePath + path
    }
}


