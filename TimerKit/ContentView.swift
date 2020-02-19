//
//  ContentView.swift
//  TimerKit
//
//  Created by Nien Lam on 2/13/20.
//  Copyright © 2020 Mobile Lab. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let arraySize = 7
    let numbers = Array((0..<10).reversed())
    // Track current index.
    @State private var currentIndex = 0
    @State private  var ci = arc4random_uniform(6) + 1
    //put pics into array
    @State private var  imageNames:[String] = ["1",
                                               "2",
                                               "3",
                                               "4",
                                               "5",
                                               "6",
                                               "7"
    ]
    // Time remaining in seconds. The source of truth.
    @State var timeRemaining = 30
    @State var timeTotal = 30
    
    // Flag for timer state.
    @State var timerIsRunning = false
    @State var timerIssetting = false
    
    func radiusAtIndex(_ index: Int,_ index2: Int) -> CGFloat {
        var p=1
        var a=1
        var b=1
        var c=CGFloat(0)
        if(index2==0||index==0){
            p=0;
            a=0;
            c=0;
            
        }
        else{
            a=360%index
            b=index2*(360/index) + a*p
            c=CGFloat(b)
        }
        return c
    }
    
    
    // Timer gets called every second.
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let number = Int.random(in: 0 ..< 370)
    var body: some View {
        //        var timerLength = (self.timeRemaining/60)*370
        
        VStack {
            
            VStack{
                // Show image if available.
                if !imageNames[currentIndex].isEmpty {
                    Image(imageNames[currentIndex])
                        .resizable()
                        .aspectRatio(contentMode:.fill)
                        .padding()
                        .frame(width: 400, height: 392)
                        //                    .border(/*@START_MENU_TOKEN@*/Color.white/*@END_MENU_TOKEN@*/, width: 1)
                        .offset(x: 0, y: 250)
                }}
            ZStack {
                
                HStack(spacing: 25){
                    
                    ForEach(numbers, id: \.self) { number in BarView(value:self.radiusAtIndex(self.timeTotal,self.timeRemaining), status:Bool.random())
                    }
                    
                    
                }
                .offset(x: 0, y: -134)
                .animation(.easeIn(duration: 1))
                
                
                
            }
            // TimeDisplay view with data bindings.
            // NOTE: Syntax used for data bindings.
            TimeDisplay(timeRemaining: $timeRemaining , timeTotal: $timeTotal)
            //            TimeDisplay(timeRemaining: $timeRemaining)
            
            
            
            
            
            
            
            HStack{
                Button(action: {
                    
                    // Toggle timer on/off.
                    self.timerIsRunning.toggle()
                    
                    // If timer is not running, reset back to 60
                    if !self.timerIssetting {
                        
                        //                    self.timeRemaining = 30
                        
                        self.timeTotal=self.timeRemaining
                        self.timerIssetting=true
                        //                        self.currentIndex+=1;
                        //
                    }
                }) {
                    // Start / Stop Button
                    ZStack{
                        
                        Text(timerIsRunning ? "" : "")
                            .fontWeight(.heavy)
                            .frame(width: 200, height: 80)
                            .background(Color(red: 10, green: 0, blue: 0, opacity: 0.4))
//                           .background(Color(red: 0.357, green: 0.482, blue:0.722, opacity: 0.5))
                            .foregroundColor(Color.white)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        
                    }
                    Image("triangle")
                        .resizable()
                        .frame(width:35,height:30)
                        .foregroundColor(.white)
                        .offset(x:-122)
                        .opacity(timerIsRunning ? 0 : 1.0)
                    Rectangle()
                        .frame(width:28,height:28)
                        .opacity(timerIsRunning ? 1.0 : 0)
                        .foregroundColor(.white)
                        .offset(x:-165)
                    
                    
                    
                }
                .offset(x: 52, y: -110)
                Button(action: {
                    
                    //                     Toggle timer on/off.
                    self.timerIssetting.toggle()
                    //                    self.timerIsRunning.toggle()
                    // If timer is not running, reset back to 60
                    if !self.timerIssetting {
                        
                        //                        self.timeRemaining = 30
                        self.timeRemaining = self.timeTotal
                        self.timeTotal=self.timeRemaining
                        //                        self.timerIssetting=true
                        self.currentIndex+=1;
                        if(self.currentIndex>=6){
                            self.currentIndex = 0
                        }
                        
                    }
                }) {
                    // Start / Stop Button
                    ZStack{
                        
                        Text(self.timerIsRunning ? "" : "")
                            .fontWeight(.heavy)
                            .frame(width: 200, height: 80)
                           .background(Color(red: 0.357, green: 0.482, blue:0.722, opacity: 0.5))
//                                                        .background(Color(red: 0, green: 0, blue:0, opacity: 0.3))
//                             .background(Color(red: 0.684, green: 0.846, blue: 0.886, opacity:1))
                            .foregroundColor(Color.white)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        
                    }
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: self.timerIssetting ? 35:3, lineCap: .square, lineJoin:.round))
                        .frame(width:35,height:35)
                        .foregroundColor(.white)
                        
                        //                        .opacity(self.timerIssetting ? 0 : 1.0)
                        .scaleEffect(self.timerIssetting ? 0.5:1.2)
                        .offset(x:-126)
                    
                    
                    
                    
                }
                .offset(x: -5, y: -110)
                
            }
        }
            
        .onReceive(timer) { _ in
            // Block gets called when timer updates.
            
            // If timeRemaining and timer is running, count down.
            if self.timeRemaining > 0 && self.timerIsRunning {
                self.timeRemaining -= 1
                
                                print("Time Remaining:", self.timeRemaining,self.timeTotal)
//                print( CGFloat( self.timeTotal)/60)
            }
            if(self.timeRemaining==0){
                self.timerIsRunning=false
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .offset(x: 0, y: 0)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BarView: View {
    var value:CGFloat
    var status:Bool
    var body: some View{
        VStack{
            ZStack(alignment:status ? .bottom : .top){
                Capsule().frame(width:15,height: 359)
                    .foregroundColor(Color(red: 10, green: 0, blue: 0, opacity: 0.05))
                    .cornerRadius(0.0)
                    .aspectRatio(contentMode:.fill)
                
                Capsule()
                    .frame(width:15,height: value)
                    .foregroundColor(.white)
                    .cornerRadius(0.0)
                    .aspectRatio(contentMode:.fill)
                
                
                
                
            }
            
            
        }
        
        
    }
}
