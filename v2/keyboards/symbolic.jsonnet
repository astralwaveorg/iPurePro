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
    
    local makeSymbol = function(symbol, row, col)
      local xPos = col * (if std.type(buttonWidth) == "object" then buttonWidth.percentage else buttonWidth / 1000);
      local yPos = row * rowHeight;
      
      button.create({
        key: symbol,
        size: { width: buttonWidth, height: buttonHeight },
        bounds: { x: { percentage: xPos }, y: { percentage: yPos } },
        backgroundStyle: "alphabeticBackgroundStyle",
        text: symbol,
        fontSize: 16,
        theme: themeConfig,
        isLetter: false,
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
      name: "符号键盘",
      author: "sicen",
      
      buttons: [
        // 第一行符号
        makeSymbol("!", 0, 0),
        makeSymbol("@", 0, 1),
        makeSymbol("#", 0, 2),
        makeSymbol("$", 0, 3),
        makeSymbol("%", 0, 4),
        makeSymbol("^", 0, 5),
        makeSymbol("&", 0, 6),
        makeSymbol("*", 0, 7),
        makeSymbol("(", 0, 8),
        makeSymbol(")", 0, 9),
        
        // 第二行符号
        makeSymbol("-", 1, 0),
        makeSymbol("_", 1, 1),
        makeSymbol("=", 1, 2),
        makeSymbol("+", 1, 3),
        makeSymbol("[", 1, 4),
        makeSymbol("]", 1, 5),
        makeSymbol("{", 1, 6),
        makeSymbol("}", 1, 7),
        makeSymbol("|", 1, 8),
        makeSymbol("\\", 1, 9),
        
        // 第三行符号
        makeSymbol(";", 2, 0),
        makeSymbol(":", 2, 1),
        makeSymbol("'", 2, 2),
        makeSymbol("\"", 2, 3),
        makeSymbol(",", 2, 4),
        makeSymbol(".", 2, 5),
        makeSymbol("<", 2, 6),
        makeSymbol(">", 2, 7),
        makeSymbol("/", 2, 8),
        makeSymbol("?", 2, 9),
        
        // 第四行符号
        makeSymbol("~", 3, 0),
        makeSymbol("`", 3, 1),
        makeSymbol("±", 3, 2),
        makeSymbol("§", 3, 3),
        makeSymbol("©", 3, 4),
        makeSymbol("®", 3, 5),
        makeSymbol("™", 3, 6),
        makeSymbol("€", 3, 7),
        makeSymbol("£", 3, 8),
        makeSymbol("¥", 3, 9),
        
        // 功能键
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
          key: "alphabetic",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 0 }, y: { percentage: 200/667 } },
          backgroundStyle: "systemButtonBackgroundStyle",
          text: "ABC",
          fontSize: 16,
          action: { switchKeyboard: "alphabetic" },
        }),
        
        makeFunction({
          key: "numeric",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 1 * (if std.type(buttonWidth) == "object" then buttonWidth.percentage else buttonWidth / 1000) }, y: { percentage: 200/667 } },
          backgroundStyle: "systemButtonBackgroundStyle",
          text: "123",
          fontSize: 16,
          action: { switchKeyboard: "numeric" },
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
          key: "moreSymbols",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 8 * (if std.type(buttonWidth) == "object" then buttonWidth.percentage else buttonWidth / 1000) }, y: { percentage: 200/667 } },
          backgroundStyle: "systemButtonBackgroundStyle",
          text: "更多",
          fontSize: 16,
          action: { nextSymbolPage: true },
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