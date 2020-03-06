import Publish
import SplashPublishPlugin
import CNAMEPublishPlugin

try MySite().publish(
    withTheme: .myTheme,
    additionalSteps: [
        .deploy(using: .gitHub("mxgzf/mxgzf.github.io"))
    ],
    plugins: [
        .splash(withClassPrefix: ""),
        .generateCNAME(with: "www.mxgzf.com")
    ]
)
