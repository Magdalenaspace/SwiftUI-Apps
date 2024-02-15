//
//  ChartView.swift
//  MyHealthApp
//
//  Created by Magdalena Samuel on 11/25/23.
//

import SwiftUI
import Charts

struct DailyStepsView: Identifiable {
    var id = UUID()
    let date: Date
    let stepCount: Double
    
}

enum ChartOptions {
    case oneWeek
    case oneMonth
    case threeMonths
    case yearToDate
    case oneYear
}

struct ChartView: View {
    @State var selectedChart: ChartOptions = .oneWeek
    @EnvironmentObject var manager: HealthManager


    var body: some View {
        VStack(spacing: 12){
            Chart {
                ForEach(manager.oneMonthChartData) { daily in
                    BarMark(x: .value(daily.date.formatted(), daily.date, unit: .day), y: .value("Steps", daily.stepCount))
                }
            }
            .foregroundColor(.green)
            .frame(height: 360)
            .padding(.horizontal)
         
            HStack {
                Button("1W") {
                    withAnimation {
                        selectedChart = .oneWeek
                        print("1 week")
                    }
                    
                }
                .padding(.all)
                .foregroundColor(selectedChart == .oneWeek ? .white : .green)
                .background(selectedChart == .oneWeek ? .green : .white)
                .cornerRadius(10)
                Button("1M") {
                    withAnimation {
                        selectedChart = .oneMonth
                        print("1 Month")
                    }
                    
                }
                .padding(.all)
                .foregroundColor(selectedChart == .oneMonth ? .white : .green)
                .background(selectedChart == .oneMonth ? .green : .white)
                .cornerRadius(10)
                Button("3M") {
                    withAnimation {
                        selectedChart = .threeMonths
                        print("3 months")
                    }
                }
                .padding(.all)
                .foregroundColor(selectedChart == .threeMonths ? .white : .green)
                .background(selectedChart == .threeMonths ? .green : .white)
                .cornerRadius(10)
                Button("YTD") {
                    withAnimation {
                        selectedChart = .yearToDate
                        print("Year To Date")
                    }
                }
                .padding(.all)
                .foregroundColor(selectedChart == .yearToDate ? .white : .green)
                .background(selectedChart == .yearToDate ? .green : .white)
                .cornerRadius(10)
                Button("1Y") {
                    withAnimation {
                        selectedChart = .oneYear
                        print("1y")
                    }
                }
                .padding(.all)
                .foregroundColor(selectedChart == .oneYear ? .white : .green)
                .background(selectedChart == .oneYear ? .green : .white)
                .cornerRadius(10)
            }
            
        }
        .onAppear { print (manager.oneMonthChartData)
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(HealthManager())
    }
}
