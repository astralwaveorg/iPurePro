{
  create: function(params={})
    local key = std.get(params, "key", "");
    local size = std.get(params, "size");
    local bounds = std.get(params, "bounds");
    local backgroundStyle = std.get(params, "backgroundStyle");
    local text = std.get(params, "text", key);
    local fontSize = std.get(params, "fontSize", 18);
    local theme = std.get(params, "theme");
    local action = std.get(params, "action", { symbol: key });
    local isLetter = std.get(params, "isLetter", false);
    
    local textColor = if isLetter then theme.alphabeticKey.textNormal else theme.functionKey.textNormal;
    local textHighlightColor = if isLetter then theme.alphabeticKey.textHighlight else theme.functionKey.textHighlight;
    
    local base = {
      key: key,
      size: size,
      bounds: bounds,
      foregroundStyle: [
        {
          text: text,
          fontSize: fontSize,
          normalColor: textColor,
          highlightColor: textHighlightColor,
          center: { x: 0.5, y: 0.5 },
        },
      ],
      action: action,
      animation: ["ButtonScaleAnimation"],
    };
    
    local withBackground = if backgroundStyle != null then
      base + { backgroundStyle: backgroundStyle }
    else
      base;
    
    if isLetter then
      withBackground + {
        uppercasedStateForegroundStyle: [
          {
            text: text,
            fontSize: fontSize,
            normalColor: textColor,
            highlightColor: textHighlightColor,
            center: { x: 0.5, y: 0.5 },
          },
        ],
        capsLockedStateForegroundStyle: [
          {
            text: text,
            fontSize: fontSize,
            normalColor: textColor,
            highlightColor: textHighlightColor,
            center: { x: 0.5, y: 0.5 },
          },
        ],
        uppercasedStateAction: { symbol: std.asciiUpper(key) },
      }
    else
      withBackground,
}