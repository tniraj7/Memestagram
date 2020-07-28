import SwiftUI
import Combine

struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.delegate = context.coordinator
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 0.1)
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}

class Coordinator: NSObject, UITextViewDelegate {
    
    var parent: MultilineTextView
    
    init(parent: MultilineTextView) {
        self.parent = parent
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.parent.text = textView.text
    }
}
