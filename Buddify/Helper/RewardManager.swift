//
//  RewardManager.swift
//  Buddify
//
//  Created by Vo Duc Tung on 07/04/16.
//  Copyright © 2016 Vo Duc Tung. All rights reserved.
//

class RewardManager: NSObject, NativeXRewardDelegate {
    class var sharedInstance : RewardManager {
        get {
            struct Static {
                static var instance : RewardManager!
            }
            
            if Static.instance == nil {
                Static.instance = RewardManager()
            }
            
            return Static.instance
        }
    }
    
    class func getRewards() {
        NativeXSDK.getRewards()
    }
    
    func addReward(id: String, name: String, amount: Int) {
        let alertController = UIAlertController(title: "Congratulations", message: "You just got \(amount) free credits.", preferredStyle: UIAlertControllerStyle.Alert)
        let cancelButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
                        
        })
        alertController.addAction(cancelButton)
        if let viewController = AppDelegate.rootViewController() {
            viewController.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    //MARK: NativeXRewardDelegate
    func rewardAvailable(rewardInfo: NativeXRewardInfo!) {
        DTLog(rewardInfo.description)
        
        guard let rewards = rewardInfo.rewards as? [NativeXReward] else {
            return
        }
        
        for reward in rewards {
            self.addReward(reward.rewardId, name: reward.rewardName, amount: reward.amount.integerValue)
        }
    }
}
