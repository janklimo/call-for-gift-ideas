module Form.Update exposing (update)

import RemoteData exposing (RemoteData(..))
import Form.Msgs exposing (..)
import Form.Models exposing (..)
import Form.Requests exposing (createCallMsg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RecipientName name ->
            { model | recipientName = name } ! []

        RecipientEmail email ->
            { model | recipientEmail = email } ! []

        RecipientSex sex ->
            { model | recipientSex = sex } ! []

        SenderName name ->
            { model | senderName = name } ! []

        SenderEmail email ->
            { model | senderEmail = email } ! []

        Validate ->
            { model | validating = True } ! []

        Submit ->
            ( { model | requestStatus = Loading }
            , createCallMsg model
            )

        BackToFormWithoutReset ->
            { model
                | requestStatus = NotAsked
                , validating = False
            }
                ! []

        BackToFormResetRecipient ->
            { model
                | requestStatus = NotAsked
                , recipientName = ""
                , recipientEmail = ""
                , validating = False
            }
                ! []

        HandleCreateCallResponse data ->
            { model | requestStatus = data } ! []
