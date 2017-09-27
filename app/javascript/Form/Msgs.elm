module Form.Msgs exposing (..)

import RemoteData exposing (RemoteData(..), WebData)


type Msg
    = RecipientName String
    | RecipientEmail String
    | SenderName String
    | SenderEmail String
    | Submit
    | Validate
    | HandleCreateCallResponse (WebData String)
    | BackToFormResetRecipient
    | BackToFormWithoutReset
