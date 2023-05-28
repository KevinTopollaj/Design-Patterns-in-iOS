import Foundation

// Abstract MessageSender protocol
protocol MessageSender {
    func sendMessage(message: String)
}

// Concrete EmailSender class
class EmailSender: MessageSender {
    func sendMessage(message: String) {
        print("Sending email message: \(message)")
    }
}

// Concrete SMSSender class
class SMSSender: MessageSender {
    func sendMessage(message: String) {
        print("Sending SMS message: \(message)")
    }
}

// MessageSenderFactory class implementing the Factory Method pattern
class MessageSenderFactory {
    enum MessageType {
        case email
        case sms
    }
    
    static func createMessageSender(type: MessageType) -> MessageSender {
        switch type {
        case .email:
            return EmailSender()
        case .sms:
            return SMSSender()
        }
    }
}

let sender = MessageSenderFactory.createMessageSender(type: .sms)
sender.sendMessage(message: "Hello Linkedin!")



