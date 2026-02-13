local theme = import "../config/theme.jsonnet";
local dimensions = import "../config/dimensions.jsonnet";
local styles = import "../tools/styles.jsonnet";
local button = import "../tools/button.jsonnet";

{
  new: function(themeName, orientation)
    local themeConfig = theme[themeName];
    local dims = dimensions[orientation];
    local buttonStyles = styles.generate(themeConfig);
    
    local buttonWidth = dims.normal;
    local buttonHeight = dimensions.buttonHeight;
    local rowHeight = dimensions.rowHeight;
    
    local makeLetter = function(key, row, col)
      local xPos = col * (if std.type(buttonWidth) == "object" then buttonWidth.percentage else buttonWidth / 1000);
      local yPos = row * rowHeight;
      
      local upperKey = if key == "q" then "Q" else if key == "w" then "W" else if key == "e" then "E" else if key == "r" then "R" else if key == "t" then "T" else if key == "y" then "Y" else if key == "u" then "U" else if key == "i" then "I" else if key == "o" then "O" else if key == "p" then "P" else if key == "a" then "A" else if key == "s" then "S" else if key == "d" then "D" else if key == "f" then "F" else if key == "g" then "G" else if key == "h" then "H" else if key == "j" then "J" else if key == "k" then "K" else if key == "l" then "L" else if key == "z" then "Z" else if key == "x" then "X" else if key == "c" then "C" else if key == "v" then "V" else if key == "b" then "B" else if key == "n" then "N" else "M";
      
      button.create({
        key: key,
        size: { width: buttonWidth, height: buttonHeight },
        bounds: { x: { percentage: xPos }, y: { percentage: yPos } },
        backgroundStyle: "alphabeticBackgroundStyle",
        text: upperKey,
        fontSize: 18,
        theme: themeConfig,
        isLetter: true,
      });
    
    local makeFunction = function(params)
      button.create({
        key: params.key,
        size: params.size,
        bounds: params.bounds,
        backgroundStyle: params.backgroundStyle,
        text: params.text,
        fontSize: params.fontSize,
        theme: themeConfig,
        isLetter: false,
        action: params.action,
      });
    
    {
      name: "字母键盘",
      author: "sicen",
      
      buttons: [
        // 第一行字母
        makeLetter("q", 0, 0),
        makeLetter("w", 0, 1),
        makeLetter("e", 0, 2),
        makeLetter("r", 0, 3),
        makeLetter("t", 0, 4),
        makeLetter("y", 0, 5),
        makeLetter("u", 0, 6),
        makeLetter("i", 0, 7),
        makeLetter("o", 0, 8),
        makeLetter("p", 0, 9),
        
        // 第二行字母
        makeLetter("a", 1, 0.5),
        makeLetter("s", 1, 1.5),
        makeLetter("d", 1, 2.5),
        makeLetter("f", 1, 3.5),
        makeLetter("g", 1, 4.5),
        makeLetter("h", 1, 5.5),
        makeLetter("j", 1, 6.5),
        makeLetter("k", 1, 7.5),
        makeLetter("l", 1, 8.5),
        
        // 第三行字母
        makeLetter("z", 2, 1),
        makeLetter("x", 2, 2),
        makeLetter("c", 2, 3),
        makeLetter("v", 2, 4),
        makeLetter("b", 2, 5),
        makeLetter("n", 2, 6),
        makeLetter("m", 2, 7),
        
        // 功能键
        makeFunction({
          key: "shift",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 0 }, y: { percentage: 150/667 } },
          backgroundStyle: "systemButtonBackgroundStyle",
          text: "⇧",
          fontSize: 16,
          action: { shift: true },
        }),
        
        makeFunction({
          key: "backspace",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 9 * (if std.type(buttonWidth) == "object" then buttonWidth.percentage else buttonWidth / 1000) }, y: { percentage: 150/667 } },
          backgroundStyle: "systemButtonBackgroundStyle",
          text: "⌫",
          fontSize: 16,
          action: { backspace: true },
        }),
        
        // 底部功能键
        makeFunction({
          key: "enZh",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 0 }, y: { percentage: 200/667 } },
          backgroundStyle: "systemButtonBackgroundStyle",
          text: "中/英",
          fontSize: 16,
          action: { switchInputMode: "zh" },
        }),
        
        makeFunction({
          key: "symbol",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 1 * (if std.type(buttonWidth) == "object" then buttonWidth.percentage else buttonWidth / 1000) }, y: { percentage: 200/667 } },
          backgroundStyle: "systemButtonBackgroundStyle",
          text: "#+=",
          fontSize: 16,
          action: { switchKeyboard: "symbolic" },
        }),
        
        makeFunction({
          key: "space",
          size: { width: dims.space, height: buttonHeight },
          bounds: { x: { percentage: 2 * (if std.type(buttonWidth) == "object" then buttonWidth.percentage else buttonWidth / 1000) }, y: { percentage: 200/667 } },
          backgroundStyle: "systemButtonBackgroundStyle",
          text: "空格",
          fontSize: 16,
          action: { insertText: " " },
        }),
        
        makeFunction({
          key: "number",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 8 * (if std.type(buttonWidth) == "object" then buttonWidth.percentage else buttonWidth / 1000) }, y: { percentage: 200/667 } },
          backgroundStyle: "systemButtonBackgroundStyle",
          text: "123",
          fontSize: 16,
          action: { switchKeyboard: "numeric" },
        }),
        
        makeFunction({
          key: "enter",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 9 * (if std.type(buttonWidth) == "object" then buttonWidth.percentage else buttonWidth / 1000) }, y: { percentage: 200/667 } },
          backgroundStyle: "enterBackgroundStyle",
          text: "换行",
          fontSize: 16,
          action: { insertText: "\n" },
        }),
      ],
      
      styles: buttonStyles,
      
      keyboardStyle: {
        backgroundColor: themeConfig.keyboardBackground,
      },
    },
}