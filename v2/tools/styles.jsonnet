{
  generate: function(theme)
    {
      alphabeticBackgroundStyle: {
        type: "alphabetic",
        normalColor: theme.alphabeticKey.backgroundNormal,
        highlightColor: theme.alphabeticKey.backgroundHighlight,
        cornerRadius: 7,
        insets: { top: 3.5, left: 2.5, bottom: 3.5, right: 2.5 },
      },
      
      systemButtonBackgroundStyle: {
        type: "system",
        normalColor: theme.functionKey.backgroundNormal,
        highlightColor: theme.functionKey.backgroundHighlight,
        cornerRadius: 7,
        insets: { top: 3.5, left: 2.5, bottom: 3.5, right: 2.5 },
      },
      
      enterBackgroundStyle: {
        type: "enter",
        normalColor: theme.enterKey.backgroundGreen,
        highlightColor: theme.enterKey.backgroundGreen,
        cornerRadius: 7,
        insets: { top: 3.5, left: 2.5, bottom: 3.5, right: 2.5 },
      },
    },
}