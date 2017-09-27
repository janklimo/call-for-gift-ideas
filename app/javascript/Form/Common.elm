module Form.Common exposing (valid)

import Form.Models exposing (Model)


valid : Model -> Bool
valid model =
    if
        String.length model.recipientName
            > 0
            && String.length model.recipientEmail
            > 0
            && String.length model.senderName
            > 0
            && String.length model.senderEmail
            > 0
    then
        True
    else
        False
