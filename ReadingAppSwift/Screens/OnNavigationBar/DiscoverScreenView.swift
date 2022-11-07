//
//  DiscoverScreenView.swift
//  ReadingAppSwift
//
//  Created by Hin, Ethan-Scott (WING) on 13/09/2022.
//

import SwiftUI

struct DiscoverScreenView: View {
    
    let recommender: Recommendations = Recommendations()
    
    let text = """

Our current level of meat consumption is unsustainable. Animal farming is a major driver of global heating and tropical deforestation. The meat industry keeps most animals in intensive, inhumane conditions. And red meat is linked to multiple health problems including heart disease and colorectal cancer.

The food industry has committed to change – chains such as McDonald’s and Burger King have signed up to net zero greenhouse gas emissions by 2050, to zero deforestation by 2030, and to multiple health targets too. But how can these giant companies, and indeed the whole food sector, possibly follow through when we consume 340bn kilos of meat a year globally, and demand is still rising? Do we just hope that consumers will go vegan or vegetarian of their own accord?

Meat alternatives are helping some convert to a plant-based lifestyle. They have grown rapidly in recent years and, on the face of it, offer a good taste at a fraction of the environmental impact of meat and without animal slaughter. However, the pace of growth has not been fast enough to achieve the scale of change needed. In the US, for example, plant-based meat alternatives represented just 1.4% of sales in 2021. McDonald’s recently launched the McPlant plant-based burger, which was successful enough to stay on the menu in the UK, but not in the US.

There is another way to reduce meat consumption. It uses a change in how food is produced to change what we consume. It can be deployed immediately and at scale. The meat in burgers or similar foods could be blended with plant-based meat alternatives, or with fresh ingredients such as mushrooms or lentils.

Discussions about the benefits of blended products have been circulating for a few years: in 2015, the James Beard Foundation started running a competition for chefs to make tastier blended burgers. The difference now is that, given the small market share of meat alternatives, and the need to cut meat consumption, blended products might be essential to achieve international sustainability targets at the scale and speed required.



"""
    
    
    var body: some View {
        NavigationView {
            Form {
                Text("Hello World")
                    .onAppear(perform: {
                        recommender.tokenize(text: text)
                    })
            }.navigationTitle("Discover")
        }
        .navigationViewStyle(.stack)
    }
}

struct DiscoverScreenView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverScreenView()
    }
}
