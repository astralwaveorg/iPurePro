local theme = import "./config/theme.jsonnet";
local dimensions = import "./config/dimensions.jsonnet";
local styles = import "./tools/styles.jsonnet";
local button = import "./tools/button.jsonnet";

{
  new: function(themeName, orientation)
    local themeConfig = theme[themeName];
    local dims = dimensions[orientation];
    local buttonStyles = styles.generate(themeConfig);
    
    local buttonWidth = dims.normal;
    local buttonHeight = dimensions.buttonHeight;
    
    local makePanelButton = function(params)
      button.create({
        key: params.key,
        size: params.size,
        bounds: params.bounds,
        backgroundStyle: "systemButtonBackgroundStyle",
        text: params.text,
        fontSize: params.fontSize,
        theme: themeConfig,
        isLetter: false,
        action: params.action,
      });
    
    {
      name: "输入法面板",
      author: "sicen",
      
      buttons: [
        // 候选词区域（占位符）
        makePanelButton({
          key: "candidate1",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 0 }, y: { percentage: 0 } },
          text: "候选1",
          fontSize: 16,
          action: { selectCandidate: 1 },
        }),
        
        makePanelButton({
          key: "candidate2",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 1 * (if std.type(buttonWidth) == "object" then buttonWidth.percentage else buttonWidth / 1000) }, y: { percentage: 0 } },
          text: "候选2",
          fontSize: 16,
          action: { selectCandidate: 2 },
        }),
        
        makePanelButton({
          key: "candidate3",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 2 * (if std.type(buttonWidth) == "object" then buttonWidth.percentage else buttonWidth / 1000) }, y: { percentage: 0 } },
          text: "候选3",
          fontSize: 16,
          action: { selectCandidate: 3 },
        }),
        
        makePanelButton({
          key: "candidate4",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 3 * (if std.type(buttonWidth) == "object" then buttonWidth.percentage else buttonWidth / 1000) }, y: { percentage: 0 } },
          text: "候选4",
          fontSize: 16,
          action: { selectCandidate: 4 },
        }),
        
        makePanelButton({
          key: "candidate5",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 4 * (if std.type(buttonWidth) == "object" then buttonWidth.percentage else buttonWidth / 1000) }, y: { percentage: 0 } },
          text: "候选5",
          fontSize: 16,
          action: { selectCandidate: 5 },
        }),
        
        // 功能按钮
        makePanelButton({
          key: "prevPage",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 5 * (if std.type(buttonWidth) == "object" then buttonWidth.percentage else buttonWidth / 1000) }, y: { percentage: 0 } },
          text: "←",
          fontSize: 16,
          action: { prevCandidatePage: true },
        }),
        
        makePanelButton({
          key: "nextPage",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 6 * (if std.type(buttonWidth) == "object" then buttonWidth.percentage else buttonWidth / 1000) }, y: { percentage: 0 } },
          text: "→",
          fontSize: 16,
          action: { nextCandidatePage: true },
        }),
        
        makePanelButton({
          key: "closePanel",
          size: { width: buttonWidth, height: buttonHeight },
          bounds: { x: { percentage: 7 * (if std.type(buttonWidth) == "object" then buttonWidth.percentage else buttonWidth / 1000) }, y: { percentage: 0 } },
          text: "×",
          fontSize: 16,
          action: { closePanel: true },
        }),
      ],
      
      styles: buttonStyles,
      
      panelStyle: {
        backgroundColor: themeConfig.keyboardBackground,
        borderColor: if themeName == "light" then "#CCCCCC" else "#333333",
        borderWidth: 1,
        cornerRadius: 8,
      },
    },
}