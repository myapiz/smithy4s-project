$version: "2"

namespace hello

use smithy.api#required
use alloy#simpleRestJson

use com.myapiz.smithy.error#NotFoundError
use com.myapiz.smithy.error#NotAuthenticatedError
use com.myapiz.smithy.error#NotAuthorizedError
use com.myapiz.smithy.auth#authorization

@simpleRestJson
@httpApiKeyAuth(name: "X-myapiz-user", in: "header")
@documentation("This service says hello and is just a demo.")
@title("Demo Service")
service Hello {
    version: "1.0.0"
    operations: [SayHello]
    errors: [NotAuthorizedError, NotAuthenticatedError, NotFoundError]
}

@http(method: "POST", uri: "/hello/{id}", code: 200)
@authorization(allow: ["write"])
@documentation(" Generate a respone with a greeting message.")
@tags(["demo"])
operation SayHello {
    input: HelloInput
    output: HelloOutput
}

structure HelloInput {
    @required
    @httpLabel
    id: String

}

structure HelloOutput {
    @required
    greeting: String
}

apply SayHello
@examples([
    {
        title: "Generate a greeting giving a name",
        documentation: "Provide a name and get a greeting back."
        input: {
            id: "friend",
        }
        output: {
            greeting: "Hello friend!"
        }
    }
])


