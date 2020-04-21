import Foundation
import Macaw

class MyView: MacawView {

    required init?(coder aDecoder: NSCoder) {
        let button = MyView.createButton()
        let chart = MyView.createChart(button)
        
        super.init(node: Group(contents: [button,chart]), coder: aDecoder)
    }
    
    private static func createButton() -> Group {
        let shape = Shape(
            form: Rect(x: -100, y: -15, w: 200, h: 30).round(r: 5),
            fill: LinearGradient(degree: 90, from: Color(val: 0xfcc07c), to: Color(val: 0xfc7600)),
            stroke: Stroke(fill: Color(val: 0xff9e4f), width: 1))

        let text = Text(
            text: "Show", font: Font(name: "Serif", size: 21),
            fill: Color.white, align: .mid, baseline: .mid,
            place: .move(dx: 15, dy: 0))

        let image = Image(src: "charts.png", w: 30, place: .move(dx: -40, dy: -15))

        return Group(contents: [shape, text, image], place: .move(dx: 375 / 2, dy: 75))
    }
    
    private static func createChart(_ button: Node) -> Group {
        var items: [Node] = []
        for i in 1...6 {
            let y = 200 - Double(i) * 30.0
            let x = 200 - Double(i) * 30.0
            items.append(Line(x1: -5, y1: y, x2: 275, y2: y).stroke(fill: Color(val: 0xF0F0F0)))
            items.append(Text(text: "\(i*30)", align: .max, baseline: .mid, place: .move(dx: -10, dy: y)))
            items.append(Text(text: "\(i)", align: .max, baseline: .mid, place: .move(dx: x, dy: 10)))
        }
        items.append(createBars(button))
        items.append(Line(x1: 0, y1: 200, x2: 275, y2: 200).stroke())
        items.append(Line(x1: 0, y1: 0, x2: 0, y2: 200).stroke())
        return Group(contents: items, place: .move(dx: 50, dy: 200))
    }
    
    static let data: [Double] = [101, 142, 66, 178, 92]
    static let palette = [0xf08c00, 0xbf1a04, 0xffd505, 0x8fcc16, 0xd1aae3].map { val in Color(val: val)}


    private static func createBars(_ button: Node) -> Group {
        var items: [Node] = []
       var animations = [Animation]()
        for (i, item) in data.enumerated() {
            let bar = Shape(
                form: Rect(x: Double(i) * 50 + 25, y: 0, w: 30, h: item),
                fill: LinearGradient(degree: 90, from: palette[i], to: palette[i].with(a: 0.3)),
                place: .scale(sx: 1, sy: 0))
            items.append(bar)
            animations.append(bar.placeVar.animation(to: .move(dx: 0, dy: -data[i]), delay: Double(i) * 0.1))
        }
        button.onTap { _ in animations.combine().play() }
        
        return Group(contents: items, place: .move(dx: 0, dy: 200))
    }

   
}


        //ADDING TEXT
//        let text = Text(text: "Hello, World!", place: .move(dx: 145, dy: 100))
//        super.init(node: text, coder: aDecoder)
        //CREATING A ROUNDED RECTANGLE
//        let shape = Shape(form: RoundRect(
//        rect: Rect(x: 100, y: 75, w: 175, h: 30),
//        rx: 5, ry: 5),fill: Color(val: 0xfcc07c),
//                          stroke: Stroke(fill: Color(val: 0xfcc07c), width: 2))
//        super.init(node: shape, coder: aDecoder)
        //CENTERING TEXTING
//        let text = Text(text: "Sample",
//                        font: Font(name: "Serif", size: 72),
//                        fill: Color.blue)
//        text.place = .move(dx: 375 / 2, dy: 75)
//        text.align = .mid
        // combining several elements together using a Group
        
        
        
        
       // let customFillUsingDegrees = LinearGradient(degree: 90, from: Color(val: 0xfcc07c), to: Color(val: 0xfc7600))
       // let customFill = LinearGradient(
        // we can define the direction as a line from the (x1, y1) to the (x2, y2) points
       // x1: 0, y1: 0, x2: 0, y2: 1,
        // when userSpace is true, the direction line will be declared in the node coordinate system
        // otherwise, the abstract coordinate system will be used where
        // (0,0) is at the top left corner of the node bounding box
        // (1,1) is at the bottom right corner of the node bounding box
      //  userSpace: false,
      //  stops: [
            // offsets should be declared between 0 (start) and 1 (finish)
//            Stop(offset: 0, color: Color(val: 0xfcc07c)),
//            Stop(offset: 1, color: Color(val: 0xfc7600))])
//        let shape = Shape(
//            form: Rect(x: -100, y: -15, w: 200, h: 30).round(r: 3),
//            fill: customFillUsingDegrees,
//            place: .move(dx: 375 / 2, dy: 75))
//        let text = Text(
//            text: "Show",
//            font: Font(name: "Serif", size: 21),
//            fill: Color.white,
//            align: .mid,
//            baseline: .mid,
//            place: .move(dx: 375 / 2, dy: 75))
//        let image = Image(src: "charts.png", w: 30, place: .move(dx: -55, dy: -15))
//        let group = Group(contents: [shape, text, image])
//        shape.onTap { event in text.fill = Color.maroon }
        //super.init(node: group, coder: aDecoder)


