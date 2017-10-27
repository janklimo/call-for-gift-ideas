module Wizard.Screens.Cards exposing (viewCardsScreen)

import Html exposing (Html, text, div, h1, h2, button, span, p, a, img, i)
import Html.Attributes exposing (..)
import Wizard.Models exposing (..)
import Wizard.Msgs exposing (..)
import Wizard.Utils exposing (icon, likedProductsCount, undecidedProducts, minimumLikedCount)
import Utils exposing (onClick)
import Animation
import Animation.Messenger
import Bootstrap.Modal as Modal
import Bootstrap.Button as Button


callToAction : Products -> Html Msg
callToAction products =
    let
        likedCount =
            likedProductsCount products

        likesNeeded =
            minimumLikedCount - likedCount

        optionString =
            if likesNeeded > 1 then
                "options"
            else
                "option"
    in
        if likedCount == 0 then
            text "Let's pick your first gift candidate!"
        else if likesNeeded > 0 then
            text
                ("Can you pick at least "
                    ++ toString likesNeeded
                    ++ " more "
                    ++ optionString
                    ++ "?"
                )
        else
            div []
                [ p []
                    [ text "Awesome! Hit "
                    , i []
                        [ text "Next" ]
                    , text " below whenever you're ready!"
                    ]
                , nextButton products
                ]


nextButton : Products -> Html Msg
nextButton products =
    if likedProductsCount products >= minimumLikedCount then
        div [ class "text-center" ]
            [ a
                [ class "btn btn-primary form-submit"
                , onClick (Navigate Sort)
                , href "#"
                ]
                [ text "Next  🚀" ]
            ]
    else
        text ""


nextButtonCard : Products -> Html Msg
nextButtonCard products =
    if likedProductsCount products >= minimumLikedCount then
        div [ id "next", class "card product" ]
            [ nextButton products
            ]
    else
        text ""


viewCard : Maybe ( Product, Extensions ) -> Animation.Messenger.State msgA -> Html Msg
viewCard product cardStyle =
    case product of
        Just ( product, extensions ) ->
            div (Animation.render cardStyle ++ [ class "product-card" ])
                [ div [ class "image-container text-center" ]
                    [ img [ src product.image_url, class "img-fluid" ] []
                    ]
                , div [ class "product-description" ]
                    [ div [ class "row" ]
                        [ div [ class "col-sm-9" ]
                            [ h2 [ class "name" ]
                                [ text product.name
                                , span [ class "price" ] [ text ("$" ++ toString product.price) ]
                                ]
                            ]
                        , div [ class "col-sm-3 more-container" ]
                            [ a [ href product.url, target "_blank", class "btn more" ] [ text "Learn more" ]
                            ]
                        ]
                    , p [ class "description" ] [ text product.description ]
                    ]
                , div [ class "text-center buttons" ]
                    [ a
                        [ class "btn btn-primary round"
                        , onClick <| FadeInFadeOut (Skip product.id)
                        , href "#"
                        ]
                        [ icon "close" ]
                    , a
                        [ class "btn btn-secondary round"
                        , onClick <| FadeInFadeOut (Like product.id)
                        , href "#"
                        ]
                        [ icon "check" ]
                    ]
                ]

        Nothing ->
            div [ class "product-card text-center" ]
                [ p [] [ text "You've gone through all the gift ideas we had 😱" ]
                , p [] [ text "Wanna give them a quick second look?" ]
                , a
                    [ class "btn btn-primary form-submit"
                    , onClick StartAgain
                    , href "#"
                    ]
                    [ text "Ok \x1F917" ]
                ]


viewCardsScreen : Model -> Html Msg
viewCardsScreen model =
    div []
        -- header card with headline and call to action
        [ div [ class "card leader" ]
            [ div [ class "text-center" ]
                [ h1 [] [ text "Anything You'd Like?" ]
                , p [] [ callToAction model.products ]
                , viewModal model
                ]
            ]

        -- product card
        , div [ id "yes-or-no", class "card product" ]
            [ viewCard (undecidedProducts model.products |> List.head) model.cardStyle
            ]
        , nextButtonCard model.products
        ]


viewModal : Model -> Html Msg
viewModal model =
    div []
        [ Button.button
            [ Button.outlineSuccess
            , Button.attrs [ onClick <| ModalMsg Modal.visibleState ]
            ]
            [ text "Open modal" ]
        , Modal.config ModalMsg
            |> Modal.small
            |> Modal.h5 [] [ text "Remove this item?" ]
            |> Modal.body [] [ p [] [ text "This is a modal for you !" ] ]
            |> Modal.footer []
                [ Button.button
                    [ Button.outlineSecondary
                    , Button.attrs [ onClick <| ModalMsg Modal.hiddenState ]
                    ]
                    [ text "Close" ]
                , Button.button
                    [ Button.primary
                    , Button.attrs [ onClick <| ModalMsg Modal.hiddenState ]
                    ]
                    [ text "Remove" ]
                ]
            |> Modal.view model.modalState
        ]
