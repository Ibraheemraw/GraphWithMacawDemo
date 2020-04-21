import Foundation
import Macaw


struct SwiftNewsVideo {
    let showNumber: String
    let videoCount: Double
    
}

class MacawChartView: MacawView {
   
    static let lastFiveVideos                = createDummyData()
    static let maxValue                      = 6000
    static let maxLineHeightValue            = 180
    static let lineWidth: Double             = 275
    
    //Using Math to Convert properties to the coordinate system
    static let dataDivisor                   = Double(maxValue/maxLineHeightValue)
    static let adjustData: [Double]          = lastFiveVideos.map({$0.videoCount / dataDivisor})
    static var animations: [Animation]       = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(node: MacawChartView.createChart(), coder: aDecoder)
        backgroundColor = .clear
    }
    
    
    private static func createDummyData() -> [SwiftNewsVideo]{
        let one = SwiftNewsVideo(showNumber: "65", videoCount: 3000)
        let two = SwiftNewsVideo(showNumber: "66", videoCount: 5200)
        let three = SwiftNewsVideo(showNumber: "67", videoCount: 4250)
        let four = SwiftNewsVideo(showNumber: "68", videoCount: 3680)
        let five = SwiftNewsVideo(showNumber: "69", videoCount: 4020)
        return [one,two,three,four,five]
    }
    
    private static func createChart() -> Group {
        var items: [Node] = addYaxisItems() + addXaxisItems()
        items.append(createBars())
        return Group(contents: items, place: .identity)
    }
    private static func addYaxisItems() -> [Node] {
        let maxLines            = 6
        let lineInterval        = Int(maxValue/maxLines)
        let yAxisHeight: Double = 200
        let lineSpacing: Double = 30
        
        var newNodes: [Node]    = []
        
        for i in 1...maxLines {
            let y = yAxisHeight - (Double(i) * lineSpacing)
            let valueLine = Line(x1: 0, y1: y, x2: lineWidth, y2: y).stroke(fill: Color.white.with(a: 0.45))
            let valueText = Text(text: "\(i * lineInterval)", align: .max, baseline: .mid, place: .move(dx: -10, dy: y))
            valueText.fill = Color.white
            newNodes.append(valueLine)
            newNodes.append(valueText)
        }
        let yAxis = Line(x1: 0, y1: 0, x2: 0, y2: yAxisHeight).stroke(fill: Color.white.with(a: 0.25))
        newNodes.append(yAxis)
        return newNodes
    }
    private static func addXaxisItems() -> [Node] {
        let chartbaseY: Double = 200
        var newNodes: [Node]   = []
        
        
        for i in 1...adjustData.count {
            let x = (Double(i) * 50)
            let valueText = Text(text: lastFiveVideos[i - 1].showNumber,align: .max, baseline: .mid, place: .move(dx: x, dy: chartbaseY + 15) )
            valueText.fill = Color.white
            newNodes.append(valueText)
        }
        let xAxis = Line(x1: 0, y1: chartbaseY, x2: lineWidth, y2: chartbaseY).stroke(fill: Color.white.with(a: 0.45))
        newNodes.append(xAxis)
        return newNodes
    }
    private static func createBars() -> Group {
        let fill = LinearGradient(degree: 90, from: Color(val: 0xfcc07c), to: Color(val: 0xfc7600))
        let items = adjustData.map{ _ in Group() }
        animations = items.enumerated().map{ (i: Int, item: Group) in
            item.contentsVar.animation(delay: Double(i) * 0.1) { t in
                let height = adjustData[i] * t
                let rect   = Rect(x: Double(i) * 50 + 25, y: 200 - height, w: 30, h: height)
                return [rect.fill(with:fill)]
            }
        }
        return items.group()
    }
    
    public static func playAnimations(){
        animations.combine().play()
    }
}
