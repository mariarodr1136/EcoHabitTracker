import SwiftUI

// MARK: - Chat Message Model
struct ChatMessage: Identifiable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date
}

// MARK: - Hugging Face API Response
struct HuggingFaceResponse: Codable {
    let generated_text: String?
}

// MARK: - Chat View Model
class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var inputMessage: String = ""
    @Published var isLoading = false
    
    // Hugging Face API token
    private let apiToken = "your_api_token_here"
    private let modelID = "facebook/blenderbot-400M-distill"
    
    init() {
        // Don't automatically send the initial message anymore
    }
    
    func sendMessage(_ content: String) {
        let userMessage = ChatMessage(content: content, isUser: true, timestamp: Date())
        messages.append(userMessage)
        
        // Get AI response
        Task {
            await getAIResponse(for: content)
        }
    }
    
    // Send the initial greeting message only when the chat opens (not on initialization)
    func sendInitialMessage() {
        // Add the initial message only once when the chat starts
        let initialMessage = "Hey superhero, ready to make a positive change in the world? Let's take action together and tackle challenges that make a real impact on our planet!"
        let systemMessage = ChatMessage(content: initialMessage, isUser: false, timestamp: Date())
        messages.append(systemMessage)
        
        // Do not trigger an AI response after sending the initial message
    }
    
    @MainActor
    private func getAIResponse(for message: String) async {
        isLoading = true
        
        guard let url = URL(string: "https://api-inference.huggingface.co/models/\(modelID)") else {
            handleError("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload = ["inputs": message]
        
        do {
            let jsonData = try JSONEncoder().encode(payload)
            request.httpBody = jsonData
            request.timeoutInterval = 30 // Set timeout interval to 30 seconds
            
            // Log HTTP request details
            print("Sending request to: \(url)")
            print("Payload: \(String(data: jsonData, encoding: .utf8) ?? "")")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Log HTTP response status and body
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                if httpResponse.statusCode != 200 {
                    handleError("Server error with status code \(httpResponse.statusCode)")
                    return
                }
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response Body: \(responseString)") // Log full response
            }
            
            // Attempt to decode the response
            if let aiResponse = try? JSONDecoder().decode([HuggingFaceResponse].self, from: data),
               let responseText = aiResponse.first?.generated_text, !responseText.isEmpty {
                let aiMessage = ChatMessage(
                    content: responseText,
                    isUser: false,
                    timestamp: Date()
                )
                // Append AI message to the messages array on the main thread
                DispatchQueue.main.async {
                    self.messages.append(aiMessage)
                }
            } else {
                handleError("Received empty response.")
            }
        } catch {
            handleError("Request failed with error: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    private func handleError(_ message: String) {
        DispatchQueue.main.async {
            let errorMessage = ChatMessage(
                content: "Sorry, I couldn't process your request. Please try again.",
                isUser: false,
                timestamp: Date()
            )
            self.messages.append(errorMessage)
            self.isLoading = false
        }
    }
}

// MARK: - Chat Bubble View
struct ChatBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser { Spacer() }
            
            Text(message.content)
                .padding(12)
                .background(message.isUser ? Color.green.opacity(0.5) : Color.gray.opacity(0.2)) // Transparent green for user message
                .foregroundColor(message.isUser ? .white : .black)
                .cornerRadius(16)
                .padding(.horizontal, 8)
            
            if !message.isUser { Spacer() }
        }
        .shadow(radius: 0) // No shadow effect
    }
}

// MARK: - Chat Interface View
struct ChatInterface: View {
    @StateObject private var viewModel = ChatViewModel()
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("AI Assistant")
                    .font(.headline)
                Spacer()
                Button(action: { isPresented = false }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color.white)
            .shadow(radius: 1)
            
            // Messages
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.messages) { message in
                        ChatBubble(message: message)
                    }
                    
                    if viewModel.isLoading {
                        HStack {
                            ProgressView()
                                .padding()
                            Spacer()
                        }
                    }
                }
                .padding(.vertical, 8)
            }
            
            // Input area
            HStack(spacing: 8) {
                TextField("Type a message...", text: $viewModel.inputMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 8)
                    .disabled(viewModel.isLoading)
                
                Button(action: {
                    guard !viewModel.inputMessage.isEmpty else { return }
                    viewModel.sendMessage(viewModel.inputMessage)
                    viewModel.inputMessage = ""
                }) {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(viewModel.isLoading ? .gray : .blue)
                }
                .disabled(viewModel.isLoading)
            }
            .padding()
            .background(Color.white)
            .shadow(radius: 1)
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 10)
        .onAppear {
            // Send initial greeting message when the chat opens
            viewModel.sendInitialMessage()
        }
    }
}

// MARK: - Floating Chat Button
struct FloatingChatButton: View {
    @Binding var showChat: Bool
    
    var body: some View {
        if !showChat { // Only show the button when the chat is closed
            Button(action: { showChat = true }) {
                Image(systemName: "message.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.green)
                    .shadow(radius: 5)
            }
            .padding()
        }
    }
}

// MARK: - Chat Container View
struct ChatContainer: View {
    @State private var showChat = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.clear
            
            if showChat {
                ChatInterface(isPresented: $showChat)
                    .frame(width: 320, height: 480)
                    .padding()
                    .transition(.move(edge: .bottom))
            }
            
            // Floating Chat Button is only visible when showChat is false
            FloatingChatButton(showChat: $showChat)
                .padding(.trailing)
                .padding(.bottom, 60)
        }
        .animation(.spring(), value: showChat)
    }
}
