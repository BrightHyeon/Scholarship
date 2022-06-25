//
//  BusanCustomView.swift
//  ADAAssessment
//
//  Created by Hyeonsoo Kim on 2022/06/24.
//

import SwiftUI
import SwiftUIX

struct Busan2View: View {
    
    @State private var searchText: String = ""
    @State private var isTitleUp: Bool = false
    @State private var isSearchBarUp: Bool = false
    
    var body: some View {
        ZStack {
            Color.offWhite.opacity(0.6)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text("장학금 목록")
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .foregroundColor(.gray)
                .padding(.top, 100)
                .padding(.horizontal, 20)
                Spacer()
                
                SearchBar("Search", text: $searchText)
                    .foregroundColor(.black)
                    .textFieldBackgroundColor(.white.withAlphaComponent(0.2))
                    .padding(.horizontal, 10)
                
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundColor(.white)
                    .frame(height: UIScreen.main.bounds.height/6*5)
                    .overlay(
                        SegmentedView()
                    )
            }
            .ignoresSafeArea()
        }
    }
}

struct Busan2View_Previews: PreviewProvider {
    static var previews: some View {
        Busan2View()
    }
}

struct SegmentedView: View {
    @Namespace var namespace
    @State private var selection: Int = 0
    
    var body: some View {
        
        VStack {
            
            HStack {
                Spacer()
                ZStack(alignment: .bottom) {
                    Text("학과 소식")
                        .modifier(UnderLine(isSelect: selection == 0, namespace: namespace))
                        .onTapGesture {
                            withAnimation {
                                selection = 0
                            }
                        }
                }
                Spacer()
                Spacer()
                ZStack(alignment: .bottom) {
                    Text("학교 소식")
                        .modifier(UnderLine(isSelect: selection == 1, namespace: namespace))
                        .onTapGesture {
                            withAnimation {
                                selection = 1
                            }
                        }
                }
                Spacer()
            }
            .font(.title2.bold())
            .padding()
            
            NoticeView(selection: $selection)
        }
    }
}

struct UnderLine: ViewModifier {
    
    var isSelect: Bool
    var namespace: Namespace.ID
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(isSelect ? Color("busan") : .secondary)
            .overlay(alignment: .bottom) {
                if isSelect {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("busan"))
                        .frame(height: 5)
                        .offset(y: 5)
                        .matchedGeometryEffect(id: "underLine", in: namespace)
                }
            }
    }
}

struct NoticeView: View {
    @Binding var selection: Int
    
    var body: some View {
        TabView(selection: $selection) {
            AView().tag(0)
            BView().tag(1)
        }
        .ignoresSafeArea()
        .tabViewStyle(PageTabViewStyle())
    }
}

struct AView: View {
    var body: some View {
        VStack {
            HStack {
                HStack(alignment: .top, spacing: 2) {
                    Text("동물생명공학전공")
                        .font(.title.bold())
                    Image(systemName: "book.closed.fill")
                        .font(.callout)
                }
                Spacer()
                Image(systemName: "pencil.circle.fill")
                    .font(.title.bold())
            }
            .foregroundColor(.green)
            .padding()
            .padding(.horizontal, 5)
            
            ScrollView {
                VStack(alignment: .center) {
                    Spacer()
                    ForEach(shipList, id: \.self) { item in
                        CardCell(content: item, selection: 0)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct BView: View {
    var body: some View {
        VStack {
            HStack {
                HStack(alignment: .top, spacing: 2) {
                    Text("부산대학교")
                        .font(.title.bold())
                    Image(systemName: "building.columns.fill")
                        .font(.callout)
                }
                Spacer()
            }
            .foregroundColor(Color("darkGreen"))
            .padding()
            .padding(.horizontal, 5)
            
            ScrollView {
                VStack(alignment: .center) {
                    Spacer()
                    ForEach(shipList, id: \.self) { item in
                        CardCell(content: item, selection: 1)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

var shipList = [
    "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
    "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
    "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
    "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 hello hello hello hello hihihihihiihihihihi[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 hello hello hello",
    "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
    "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
    "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
    "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
    "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
    "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
    "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
    "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
    "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원",
    "[장학] 2022년도 부산대학교 생명자원과학대학 학부생 대상 장학금 200만원"
]


struct CardCell: View {
    
    var content: String
    var selection: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Circle()
                    .frame(width: 4, height: 4)
                    .foregroundColor(selection == 0 ? .green : Color("darkGreen"))
                HStack(spacing: 3) {
                    Circle()
                        .frame(width: 4, height: 4)
                        .foregroundColor(selection == 0 ? .green : Color("darkGreen"))
                    Circle()
                        .frame(width: 4, height: 4)
                        .foregroundColor(selection == 0 ? .green : Color("darkGreen"))
                }
            }.offset(y: -3)
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: UIScreen.main.bounds.width*0.85,
                       height: UIScreen.main.bounds.width*0.25
                )
                .foregroundColor(.white)
                .shadow(
                    color: selection == 0 ? .green.opacity(0.1) : Color("darkGreen").opacity(0.05),
                    radius: 4, x: 0, y: -3)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                .overlay(
                    Text(content)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .padding()
                )
        }
        .padding(3)
    }
}

extension Color {
    //For Neumorphism
    static let offWhite = Color(red: 225/255, green: 225/255, blue: 235/255)
}
