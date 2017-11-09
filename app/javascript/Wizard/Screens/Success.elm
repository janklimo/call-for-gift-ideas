module Wizard.Screens.Success exposing (viewSuccessScreen)

import Html exposing (..)
import Html.Attributes exposing (..)
import Wizard.Msgs exposing (..)
import Wizard.Utils exposing (..)
import Wizard.Models exposing (..)


viewSuccessScreen : Model -> Html Msg
viewSuccessScreen model =
    div [ class "card success" ]
        [ img [ src "https://s3-us-west-1.amazonaws.com/slackface/party.gif" ] []
        , h1 [ class "text-center success__headline" ] [ text ("You Did It, " ++ model.recipientName ++ "! 😻") ]
        , div [ class "success__body text-center" ]
            [ p [] [ text "Your wishlist has been sent to the person who requested it 🚀" ]
            , p [] [ text "Time to get excited about the awesome present you're about to receive 💖" ]
            , h2 [ class "success__byline" ] [ text "But Wait!" ]
            , p [] [ text "Don't break the chain ⛓️" ]
            , p []
                [ b [ class "highlight" ] [ text "9 people" ]
                , span [] [ text " submitted their wishlist and passed it forward before it reached you! " ]
                , span [] [ text "Send a new call for gift ideas to somebody you care about." ]
                ]
            , a
                [ class ("btn btn-primary form-submit")
                , href "/"
                ]
                [ text "Let's Go  🚀" ]
            , h2 [ class "success__byline" ] [ text "Spread the 💖" ]
            , a
                [ class "sc-btn sc--twitter sc--flat"
                , target "_blank"
                , href "https://twitter.com/intent/tweet?text=Finding%20the%20perfect%20%23gift%20idea%20has%20never%20been%20easier%20%F0%9F%91%8D%F0%9F%9A%80%20Try%20it%20now!%20%F0%9F%92%AF%F0%9F%94%A5&url=https://www.callforgiftideas.com&via=janklimo&hashtags=christmas,birthday"
                ]
                [ span [ class "sc-icon" ] [ icon "twitter" ]
                , span [ class "sc-text" ] [ text "on Twitter" ]
                ]
            ]
        ]
