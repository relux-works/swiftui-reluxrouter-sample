import Relux

extension ReluxRouterSample {
    struct ReluxLogger: Relux.Logger {
        func logAction(
            _ action: any Relux.EnumReflectable,
            result: Relux.ActionResult?,
            startTimeInMillis: Int,
            privacy: Relux.OSLogPrivacy,
            fileID: String,
            functionName: String,
            lineNumber: Int
        ) {}
    }
}
