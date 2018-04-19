//
//  RefreshHeader.swift
//  Refresh
//
//  Created by 姜守栋 on 2018/4/18.
//  Copyright © 2018年 Nick.Inc. All rights reserved.
//

import UIKit
fileprivate let headerHeight: CGFloat = 64.0
class RefreshHeader: RefreshBaseView {
    
    override var state: RefreshState {
        
        didSet {
            print(state)
        }
    }
    
    static func header(with refreshingBlcok: @escaping refreshBlcok ) -> RefreshHeader {
        let header = self.init()
        header.refreshingBlock = refreshingBlcok
        return header
        
    }
    
    override func placeSubviews() {
        sd_x = 0.0
        sd_height = headerHeight
        sd_width = (scrollView?.sd_width)!
        sd_y = -sd_height
    }
    
    override func scrollViewContentOffsetChanged(_ value: [NSKeyValueChangeKey : Any]?) {
        
        guard let scrollView = scrollView else {
            return
        }
        if scrollView.isDragging {
            
            if state == .idle && scrollView.sd_offsetY < -headerHeight {
                state = .pulling
            } else if state == .pulling && scrollView.sd_offsetY > -headerHeight {
                state = .idle
            }
            
        } else {
            
            if state == .pulling && scrollView.sd_offsetY <= -headerHeight {
                state = .refreshing
            }
            
        }
        
    }
    
    
}
