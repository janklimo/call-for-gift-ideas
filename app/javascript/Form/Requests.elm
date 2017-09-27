module Form.Requests exposing (createCallMsg)

import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import RemoteData.Http
import Form.Models exposing (..)
import Form.Msgs exposing (..)


createCallUrl : String
createCallUrl =
    "/calls"


callDecoder : Decoder String
callDecoder =
    Decode.field "status" Decode.string


callEncoder : Model -> Encode.Value
callEncoder model =
    Encode.object
        [ ( "sender_name", Encode.string model.senderName )
        , ( "sender_email", Encode.string model.senderEmail )
        , ( "recipient_name", Encode.string model.recipientName )
        , ( "recipient_email", Encode.string model.recipientEmail )
        ]


createCallMsg : Model -> Cmd Msg
createCallMsg model =
    RemoteData.Http.post
        createCallUrl
        HandleCreateCallResponse
        callDecoder
        (callEncoder model)
