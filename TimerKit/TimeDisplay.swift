//
//  TimeDisplay.swift
//  TimerKit
//
//  Created by Nien Lam on 2/13/20.
//  Copyright © 2020 Mobile Lab. All rights reserved.
//

import SwiftUI

struct TimeDisplay: View {
    // Binding variable.
    @Binding var timeRemaining: Int
    @Binding var timeTotal: Int
    @State var textAnimation = false
     @State var textAnimation2 = false
    
    func SLength(_ index: Int) -> CGFloat {
        var p=CGFloat(0)
        if(index==60||index>=3600){
            
            p=CGFloat(0)
        }else{
            p=CGFloat(index%60)/60
        }
        return p
    }
    func MLength(_ index: Int) -> CGFloat {
        var p=CGFloat(0)
        var m=CGFloat((index/60)%60)
        if(index>=3600){
            p=CGFloat(60)
        }else{
            p=m}
        return p
    }
    
    var body: some View {
        //        Text("\(timeRemaining)")
        
        HStack{
            Text("+")
                .font(.system(size: 40))
                .foregroundColor(.init(red:0/255, green: 0/255, blue: 0/255, opacity: 0.5))
                .scaleEffect(self.textAnimation ? 1.2:1)
                .offset(x:180,y:-110)
                .onTapGesture {
                    // On tap gesture, increment timer by 10.
                    self.timeRemaining += 10
                    
                    self.timeTotal=self.timeRemaining
                    self.textAnimation.toggle()
                    
            }
            
            //                Text("\(timeRemaining)")
            //                       .font(.system(size:35))
            //                       .foregroundColor(.gray)
            //                    .offset(x:80,y:-110)
            
            ZStack{
                ZStack{
                    
                    Circle()
                        .trim(from:0,to:1)
                        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .square, lineJoin:.round))
                        .foregroundColor(.init(red:0/255, green: 0/255, blue: 0/255, opacity: 0.1))
                        .scaleEffect(0.8)
                        .offset(x:100,y:-30)
                        .rotationEffect(.degrees(-90) )
                    
                    
                    Circle()
                        .trim(from:0,to:self.SLength(self.timeTotal))
                        .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .square, lineJoin:.round))
                        .foregroundColor(.init(red:0/255, green: 0/255, blue: 0/255, opacity: 0.5))
                        .scaleEffect(0.8)
                        .offset(x:100,y:-30)
                        .rotationEffect(.degrees(-90) )}
                
                ZStack{
                    Circle()
                        .trim(from:0,to:1)
                        .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .square, lineJoin:.round))
                        .foregroundColor(.init(red:0/255, green: 0/255, blue: 0/255, opacity: 0.1))
                        .scaleEffect(1.3)
                        .offset(x:100,y:-30)
                        .rotationEffect(.degrees(-90) )
                    Circle()
                        .trim(from:0,to:self.MLength(self.timeTotal)/60)
                        .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .square, lineJoin:.round))
                        .foregroundColor(.init(red:0/255, green: 0/255, blue: 0/255, opacity: 0.5))
                        .scaleEffect(1.3)
                        .offset(x:100,y:-30)
                        .rotationEffect(.degrees(-90) )
                    
                    
                }
            }
            .offset(x:30)
            
            
            
            Text("-")
                .font(.system(size: 48))
                .foregroundColor(.init(red:0/255, green: 0/255, blue: 0/255, opacity: 0.5))
                .scaleEffect(self.textAnimation2 ? 1.2:1)
                .offset(x:-180,y:-110)
                
                .onTapGesture {
                    // On tap gesture, increment timer by 10.
                    self.timeRemaining -= 10
                    self.timeTotal=self.timeRemaining
                    if(self.timeRemaining<=0){
                        self.timeRemaining=0
                      
                    }
                      self.textAnimation2.toggle()
            }
        }
    }
}

struct TimeDisplay_Previews: PreviewProvider {
    static var previews: some View {
        TimeDisplay(timeRemaining: .constant(80), timeTotal: .constant(80))
        
    }
}
