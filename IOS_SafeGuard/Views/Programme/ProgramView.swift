
import SwiftUI

struct ProgramView: View {
    @ObservedObject var viewModel = ProgramViewModel()

    var body: some View {
      
           
                List(viewModel.programs) { program in
                    
                    NavigationLink(destination: CoursView(program: program)) {
                        ProgramCardView(program: program)
                            .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 4, trailing: 4))
                    }
                }
                .onAppear {
                    viewModel.getAllPrograms()
                }
                .navigationTitle("Programmes")
                
        
        
        
        
    }
}
