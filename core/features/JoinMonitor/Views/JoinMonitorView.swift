import Foundation
import SwiftUI

struct JoinMonitorView: View {
    @ObservedObject var joinMonitorViewModel: JoinMonitorViewModel

    init() {
        _joinMonitorViewModel = ObservedObject(wrappedValue: JoinMonitorViewModel())
    }

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                StepIndicator(currentStep: 1, dotCount: 1)
                    .padding(.leading, 35)
                    .padding(.top, 35)

                Spacer()
            }

            Form {
                Section {
                    TextField("Monitor-ID", text: Binding(get: {
                        joinMonitorViewModel.monitorHash
                    }, set: {
                        joinMonitorViewModel.dataChanged(monitorHash: $0)
                    }))
                    .textFieldStyle(TextFieldPrimaryStyle())
                }
            }
            .formStyle(.columns)
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Join Monitor")
            .listSectionSpacing(0)
            .scrollContentBackground(.hidden)
            .padding(.horizontal, 35)
            .padding(.vertical, 15)

            Rectangle()
                .fill(Color.gray)
                .frame(height: 150)
                .padding(.horizontal, 35)

            HStack {
                Button {
                    joinMonitorViewModel.joinMonitor()
                } label: {
                    Text("skip")
                }

                Spacer()

                Button {
                    print("jfhdhhdf")
                } label: {
                    Text("skip")
                }.buttonStyle(.borderedProminent)

            }.padding(.horizontal, 35)

            Spacer()

            HStack {
                NavigationLink(destination: ChooseProviderView()) {
                    Text("Create one instead")
                }.padding(.horizontal, 35)

                Spacer()
            }
        }
    }
}
