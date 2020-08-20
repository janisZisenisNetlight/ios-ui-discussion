class WelcomeServiceImp: WelcomeService {
    func fetchTitle() -> WelcomeEntity {
        return WelcomeEntity(
                title: "Welcome to the iOS UI discussion. Let's discuss about how to set up views in source code. 💥",
                numberOfVisitedUsers: 5,
                settingOff: false,
                settingName: "Fancy Setting"
        )
    }
}
