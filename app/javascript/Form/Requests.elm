module Form.Requests exposing (..)

import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)
import Http
import RemoteData.Http
import Form.Models exposing (..)


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
