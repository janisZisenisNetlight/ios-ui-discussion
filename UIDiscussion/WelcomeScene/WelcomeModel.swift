enum WelcomeModel {
    enum ViewDidLoad {
        struct Request {
        }
        struct Response {
            let entity: WelcomeEntity
            let canBeContinued: Bool
            let settingName: String
            let settingOff: Bool
        }
        struct ViewModel {
            let title: String
            let isContinueButtonEnabled: Bool
            let settingName: String
            let settingOff: Bool
        }
    }

    enum ViewWillAppear {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
        }
    }

    enum Continue {
        struct Request {
        }
    }

    enum SettingsChanged {
        struct Request {
            let newSettingState: Bool
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
}
