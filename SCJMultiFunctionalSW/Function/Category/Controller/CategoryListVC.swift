//
//  CategoryListVC.swift
//  SCJMultiFunctionalSW
//
//  Created by scj on 2021/11/25.
//

import UIKit
import JXSegmentedView

class CategoryListVC: UIViewController {
    
    var segmentedDataSource = JXSegmentedBaseDataSource()
    let segmentedView = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    var arrj: NSMutableArray = ["0"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = kRandomColor()
        
        let dataSource = JXSegmentedDotDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titles = ["消息","评论"]
        dataSource.titleNormalColor = RGB16(rgbValue: 0x222222)
        dataSource.titleSelectedColor = kRandomColor()
        dataSource.dotStates = [false,true]
        
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 24
        indicator.indicatorHeight = 3
        indicator.indicatorColor = kRandomColor()
        
        segmentedDataSource = dataSource
        segmentedView.indicators = [indicator]
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        
        segmentedView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 44)
        listContainerView.frame = CGRect(x: 0, y: 44, width: kScreenWidth, height: kScreenHeight - 44 - 45 - kStatusBarHeight)
        
        view.addSubview(segmentedView)
        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)
        
//        print("---scj---666-",self.find_str(str: "mmnnccfgsdds"))
//        self.find_number(number: 1000)
//        print("---scj-:",self.invertNum(number: -123))
//        print("---scj--arr:",self.sumNum([0,3,6], 6))
//        var intArray: [Int] = [1,1,2,3,3,4]
//        print("---scj-count:",self.removeDuplicates(&intArray))
//        var intArray: [Int] = [3,4,5,3]
//        print("---scj-count:",self.removeElement(&intArray, 3))
//        print("---scj--sugar:",self.distributeCandies([6,6,6,5]))
//        print("---scj--str:",self.lengthOfLongestSubstring("pwwkew"))
        print("---scj--letter:",self.letterCombinations("245"))
    }
    
    /**
     取出只出现字母：
     1.循环遍历目标字符串，以单个字符为key创建字典，值为出现次数，同时将字符串存入数组
     2.取数组字符串为key，找出字典value为1的字符
     */
    func find_str(str:NSString) -> NSString{
        let dic = NSMutableDictionary()
        let arr = NSMutableArray()
        var string = NSString()
        
        for i in Array(str as String) {
            if (dic[i] != nil) {
                var value = dic[i] as! NSInteger
                value += 1
                dic[i] = value
            }
            else {
                dic[i] = 1
                arr.add(i)
            }
        }
        for i in arr {
            if dic[i] as! Int == 1 {
                print("----scj-",i)
                string = string.appending("\(i)") as NSString
                continue
            }
            else {
                print("----scj-NO-",i)
                continue
            }
        }
        return string
    }
    
    /**
     中心对称数字：
     根据输入目标数长度 构建特定的中心数
     1.首位不为0
     2.长度不能大于目标数
     3.固定中心数去构建，但如果将要构建的数长度大于目标数，则停止构建
     */
    func find_number(number:NSInteger) {
        dfs(cur: "", number: number)
        dfs(cur: "1", number: number)
        dfs(cur: "0", number: number)
        dfs(cur: "8", number: number)
        
        print("--scj--arr:",self.arrj)
    }
    
    func dfs(cur:String,number:NSInteger) {
        print("---scj-cur:",cur)
        
        let str = String(number)
        let firstCurChar = (cur.count != 0) ? cur.first : "0"
        
        if (firstCurChar != "0" && cur.count <= str.count) {
            self.arrj.add(cur as NSString)
        }
        
        if cur.count + 2 > str.count {
            return
        }
        
        dfs(cur: "0" + cur + "0", number: number)
        dfs(cur: "1" + cur + "1", number: number)
        dfs(cur: "6" + cur + "9", number: number)
        dfs(cur: "9" + cur + "6", number: number)
        dfs(cur: "8" + cur + "8", number: number)
    }
    
    /**
     数字倒换:
     1.目标数依次 %10 得到的单个数
     2.单个数 依次 *10 得到新数
     3.目标数依次 /10 缩小
     -2^31 - 1 <= x <= 2^31
     */
    func invertNum(number:NSInteger) -> Int {
        var a = number
        var b = 0
        while a != 0 {
            b = b*10 + a%10
            a /= 10
        }
        print("---scj:",b)
        return b > 2147483648 || b < -2147483647  ? 0 : b
    }
    
    /**
     给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。

     你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。

     你可以按任意顺序返回答案。
     */
    func sumNum(_ nums: [Int], _ target: Int) -> [Int] {
//        let arr = NSMutableArray()
//
//        for i in 0..<nums.count {
//            let a = nums[i]
//
//            for j in (i + 1)..<nums.count {
//                let b = nums[j]
//
//                if a + b == target {
//                    arr.add(i)
//                    arr.add(j)
//                    break
//                }
//            }
//        }
//        return arr as! [Int]
        var dic = [Int:Int]()
        
        for (key,value) in nums.enumerated() {
            dic[value] = key
        }
        for (index, n) in nums.enumerated() {
            if dic.keys.contains(target - n) && index != dic[target - n] {
                return [index,dic[target - n]!]
            }
        }
        return []
    }
    
    /**
     给你一个有序数组 nums ，请你 原地 删除重复出现的元素，使每个元素 只出现一次 ，返回删除后数组的新长度。

     不要使用额外的数组空间，你必须在 原地 修改输入数组 并在使用 O(1) 额外空间的条件下完成。
     */
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        var i = 0
        while i + 1 < nums.count {
            if nums[i] == nums[i + 1] {
                nums.remove(at: i + 1)
                continue
            }
            i += 1
        }
        return nums.count
//        if nums.count <= 1 {
//            return nums.count
//        }
//        var newIndex = 1
//        for i in 1 ..< nums.count {
//            if nums[i] != nums[i-1]  {
//                nums[newIndex] = nums[i]
//                newIndex += 1
//            }
//        }
//        return newIndex
    }
    
    /**
     给你一个数组 nums 和一个值 val，你需要 原地 移除所有数值等于 val 的元素，并返回移除后数组的新长度。

     不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并 原地 修改输入数组。

     元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。
     */
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var i = 0
        while i < nums.count {
            if val == nums[i] {
                nums.remove(at: i)
                continue
            }
            i += 1
        }
        return nums.count
    }
    
    /**
     Alice 有 n 枚糖，其中第 i 枚糖的类型为 candyType[i] 。Alice 注意到她的体重正在增长，所以前去拜访了一位医生。

     医生建议 Alice 要少摄入糖分，只吃掉她所有糖的 n / 2 即可（n 是一个偶数）。Alice 非常喜欢这些糖，她想要在遵循医生建议的情况下，尽可能吃到最多不同种类的糖。

     给你一个长度为 n 的整数数组 candyType ，返回： Alice 在仅吃掉 n / 2 枚糖的情况下，可以吃到糖的最多种类数。
     */
    func distributeCandies(_ candyType: [Int]) -> Int {
//        var arr:[Int] = []
//        let dic = NSMutableDictionary()
//        for i in 0..<candyType.count {
//            if (dic[candyType[i]] == nil && arr.count < candyType.count / 2) {
//                dic[candyType[i]] = 1
//                arr.append(candyType[i])
//            }
//        }
//        return arr.count
        min(Set(candyType).count, candyType.count / 2)
    }
    
    /**
     给定一个字符串 s ，请你找出其中不含有重复字符的 最长子串 的长度。
     */
    func lengthOfLongestSubstring(_ s: String) -> Int {
//        let str1 = "123456789"
//
//        guard let range = str1.range(of: "4567") else {
//            return 1
//        }
//        //截取
//        print(str1[..<range.lowerBound])//123
//        print(str1[range.upperBound...])//89
//        print(str1.prefix(upTo: range.lowerBound))//123
//        print(str1.suffix(from: range.upperBound))//89

        var str = String()
        var maxStr = String()
        
        for i in Array(s as String) {
            if (!str.contains(i)) {
                str.append(i)
                if maxStr.count < str.count {
                    maxStr = str
                }
            }
            else {
                let range = str.range(of: String(i))
                str = String(str[range!.upperBound...])
                str.append(i)
            }
        }
        return maxStr.count
    }
    
    /**
     给定一个仅包含数字 2-9 的字符串，返回所有它能表示的字母组合。答案可以按 任意顺序 返回
     2:a、b、c；3:d、e、f；4:g、h、i；5:j、k、l；6:m、n、o；7:p、q、r、s；8:t、u、v；9:w、x、y、z
     
     "245":["agj", "agk", "agl", "ahj", "ahk", "ahl", "aij", "aik", "ail", "bgj", "bgk", "bgl", "bhj", "bhk", "bhl", "bij", "bik", "bil", "cgj", "cgk", "cgl", "chj", "chk", "chl", "cij", "cik", "cil"]
     */
    func letterCombinations(_ digits: String) -> [String] {
        
        var m = [
            "2": "abc",
            "3": "def",
            "4": "ghi",
            "5": "jkl",
            "6": "mno",
            "7": "pqrs",
            "8": "tuv",
            "9": "wxyz",
        ]
        var digits = digits.map({ (i: Character) -> String in return m[String(i)]! })

        var arr = [String]()
        func loop(_ s: String, _ h: Int) {
            if digits.count <= h {
                if s != "" { arr.append(s) }
                return
            }
            for i in digits[h] {
                loop(s + String(i), h + 1)
            }
        }

        loop("", 0)
        return arr
            
    }
}

extension CategoryListVC: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            //先更新数据源的数据
            dotDataSource.dotStates[index] = false
            for i in 0..<dotDataSource.dotStates.count{
                if i != index {
                    dotDataSource.dotStates[i] = true
                    segmentedView.reloadItem(at: i)
                }
            }
            
            //再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
        }

        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
}

extension CategoryListVC: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return SunVC.init()
    }
}

extension CategoryListVC: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
