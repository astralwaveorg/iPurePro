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
    local colWidth = if orientation == "portrait" then 1/3 else 1/4;
    
    local makeNumber = function(num, row, col)
      local xPos = col * colWidth;
      local yPos = row * rowHeight;
      
      button.create({
        key: std.toString(num),
        size: { width: buttonWidth, height: buttonHeight },
        bounds: { x: { percentage: xPos }, y: { percentage: yPos } },
        backgroundStyle: "alphabeticBackgroundStyle",
        text: std.toString(num),
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
      name: "数字键盘",
      author: "sicen",
      
      buttons: [
        // 数字 1-3
        makeNumber(1, 0, 0),
        makeNumber(2, 0, 1),
        makeNumber(3, 0, 2),
        
        // 数字 4-6
        makeNumber(4, 1, 0),
        makeNumber(5, 1, 1),
        makeNumber(6, 1, 2),
        
        // 数字 7-9
        makeNumber(7, 2, 0),
        makeNumber(8, 2, 1),
        makeNumber(9, 2, 2),
        
        // 功能键
        makeFunction({
          key: "symbol",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 0 }, y: { percentage: 150/667 } },
          backgroundStyle: "systemButtonBackgroundStyle",
          text: "#+=",
          fontSize: 16,
          action: { switchKeyboard: "symbolic" },
        }),
        
        makeNumber(0, 3, 1),
        
        makeFunction({
          key: "backspace",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 2 * colWidth }, y: { percentage: 150/667 } },
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
          key: "alphabetic",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: colWidth }, y: { percentage: 200/667 } },
          backgroundStyle: "systemButtonBackgroundStyle",
          text: "ABC",
          fontSize: 16,
          action: { switchKeyboard: "alphabetic" },
        }),
        
        makeFunction({
          key: "space",
          size: { width: dims.space, height: buttonHeight },
          bounds: { x: { percentage: 2 * colWidth }, y: { percentage: 200/667 } },
          backgroundStyle: "systemButtonBackgroundStyle",
          text: "空格",
          fontSize: 16,
          action: { insertText: " " },
        }),
        
        makeFunction({
          key: "enter",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 3 * colWidth }, y: { percentage: 200/667 } },
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