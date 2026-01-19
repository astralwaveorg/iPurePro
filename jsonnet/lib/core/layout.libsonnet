// 键盘布局定义
local constants = import "../core/constants.libsonnet";

{
  // 竖屏中文26键布局
  portraitChinese26: {
    keyboardLayout: [
      {
        HStack: {
          subviews: [
            { Cell: "qButton" },
            { Cell: "wButton" },
            { Cell: "eButton" },
            { Cell: "rButton" },
            { Cell: "tButton" },
            { Cell: "yButton" },
            { Cell: "uButton" },
            { Cell: "iButton" },
            { Cell: "oButton" },
            { Cell: "pButton" },
          ],
        },
      },
      {
        HStack: {
          subviews: [
            { Cell: "aButton" },
            { Cell: "sButton" },
            { Cell: "dButton" },
            { Cell: "fButton" },
            { Cell: "gButton" },
            { Cell: "hButton" },
            { Cell: "jButton" },
            { Cell: "kButton" },
            { Cell: "lButton" },
          ],
        },
      },
      {
        HStack: {
          subviews: [
            { Cell: "shiftButton" },
            { Cell: "zButton" },
            { Cell: "xButton" },
            { Cell: "cButton" },
            { Cell: "vButton" },
            { Cell: "bButton" },
            { Cell: "nButton" },
            { Cell: "mButton" },
            { Cell: "backspaceButton" },
          ],
        },
      },
      {
        HStack: {
          subviews: [
            { Cell: "EnZhButton" },
            { Cell: "symbolButton" },
            { Cell: "numberButton" },
            { Cell: "spaceButton" },
            { Cell: "spaceRightButton" },
            { Cell: "enterButton" },
          ],
        },
      },
    ],
    keyboardStyle: {
      insets: { top: 1 },
      backgroundStyle: "keyboardBackgroundStyle",
    },
  },

  // 横屏中文26键布局
  landscapeChinese26: {
    keyboardLayout: [
      {
        VStack: {
          style: "columnStyle1",
          subviews: [
            {
              HStack: {
                subviews: [
                  { Cell: "qButton" },
                  { Cell: "wButton" },
                  { Cell: "eButton" },
                  { Cell: "rButton" },
                  { Cell: "tButton" },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: "aButton" },
                  { Cell: "sButton" },
                  { Cell: "dButton" },
                  { Cell: "fButton" },
                  { Cell: "gButton" },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: "shiftButton" },
                  { Cell: "zButton" },
                  { Cell: "xButton" },
                  { Cell: "cButton" },
                  { Cell: "vButton" },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: "EnZhButton" },
                  { Cell: "symbolButton" },
                  { Cell: "spaceButton" },
                ],
              },
            },
          ],
        },
      },
      {
        VStack: {
          style: "columnStyle2",
        },
      },
      {
        VStack: {
          style: "columnStyle3",
          subviews: [
            {
              HStack: {
                subviews: [
                  { Cell: "yButton" },
                  { Cell: "uButton" },
                  { Cell: "iButton" },
                  { Cell: "oButton" },
                  { Cell: "pButton" },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: "gButton" },
                  { Cell: "hButton" },
                  { Cell: "jButton" },
                  { Cell: "kButton" },
                  { Cell: "lButton" },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: "vButton" },
                  { Cell: "bButton" },
                  { Cell: "nButton" },
                  { Cell: "mButton" },
                  { Cell: "backspaceButton" },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: "numberButton" },
                  { Cell: "spaceRightButton" },
                  { Cell: "enterButton" },
                ],
              },
            },
          ],
        },
      },
    ],
    keyboardStyle: {
      insets: { top: 1 },
      backgroundStyle: "keyboardBackgroundStyle",
    },
  },

  // 竖屏英文26键布局
  portraitEnglish26: {
    keyboardLayout: [
      {
        HStack: {
          subviews: [
            { Cell: "qButton" },
            { Cell: "wButton" },
            { Cell: "eButton" },
            { Cell: "rButton" },
            { Cell: "tButton" },
            { Cell: "yButton" },
            { Cell: "uButton" },
            { Cell: "iButton" },
            { Cell: "oButton" },
            { Cell: "pButton" },
          ],
        },
      },
      {
        HStack: {
          subviews: [
            { Cell: "aButton" },
            { Cell: "sButton" },
            { Cell: "dButton" },
            { Cell: "fButton" },
            { Cell: "gButton" },
            { Cell: "hButton" },
            { Cell: "jButton" },
            { Cell: "kButton" },
            { Cell: "lButton" },
          ],
        },
      },
      {
        HStack: {
          subviews: [
            { Cell: "shiftButton" },
            { Cell: "zButton" },
            { Cell: "xButton" },
            { Cell: "cButton" },
            { Cell: "vButton" },
            { Cell: "bButton" },
            { Cell: "nButton" },
            { Cell: "mButton" },
            { Cell: "backspaceButton" },
          ],
        },
      },
      {
        HStack: {
          subviews: [
            { Cell: "EnZhButton" },
            { Cell: "symbolButton" },
            { Cell: "numberButton" },
            { Cell: "spaceButton" },
            { Cell: "spaceRightButton" },
            { Cell: "enterButton" },
          ],
        },
      },
    ],
    keyboardStyle: {
      insets: { top: 1 },
      backgroundStyle: "keyboardBackgroundStyle",
    },
  },

  // 横屏英文26键布局
  landscapeEnglish26: {
    keyboardLayout: [
      {
        VStack: {
          style: "columnStyle1",
          subviews: [
            {
              HStack: {
                subviews: [
                  { Cell: "qButton" },
                  { Cell: "wButton" },
                  { Cell: "eButton" },
                  { Cell: "rButton" },
                  { Cell: "tButton" },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: "aButton" },
                  { Cell: "sButton" },
                  { Cell: "dButton" },
                  { Cell: "fButton" },
                  { Cell: "gButton" },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: "shiftButton" },
                  { Cell: "zButton" },
                  { Cell: "xButton" },
                  { Cell: "cButton" },
                  { Cell: "vButton" },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: "EnZhButton" },
                  { Cell: "symbolButton" },
                  { Cell: "spaceButton" },
                ],
              },
            },
          ],
        },
      },
      {
        VStack: {
          style: "columnStyle2",
        },
      },
      {
        VStack: {
          style: "columnStyle3",
          subviews: [
            {
              HStack: {
                subviews: [
                  { Cell: "yButton" },
                  { Cell: "uButton" },
                  { Cell: "iButton" },
                  { Cell: "oButton" },
                  { Cell: "pButton" },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: "gButton" },
                  { Cell: "hButton" },
                  { Cell: "jButton" },
                  { Cell: "kButton" },
                  { Cell: "lButton" },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: "vButton" },
                  { Cell: "bButton" },
                  { Cell: "nButton" },
                  { Cell: "mButton" },
                  { Cell: "backspaceButton" },
                ],
              },
            },
            {
              HStack: {
                subviews: [
                  { Cell: "numberButton" },
                  { Cell: "spaceRightButton" },
                  { Cell: "enterButton" },
                ],
              },
            },
          ],
        },
      },
    ],
    keyboardStyle: {
      insets: { top: 1 },
      backgroundStyle: "keyboardBackgroundStyle",
    },
  },

  // 列样式
  columnStyle1: {
    size: { width: constants.LAYOUT.COLUMN_RATIOS.PORTRAIT.LEFT },
  },
  columnStyle2: {
    size: { width: constants.LAYOUT.COLUMN_RATIOS.PORTRAIT.MIDDLE },
  },
  columnStyle3: {
    size: { width: constants.LAYOUT.COLUMN_RATIOS.PORTRAIT.RIGHT },
  },

  // 获取布局
  getLayout(keyboardType, orientation):
    if keyboardType == "chinese" && orientation == "portrait" then self.portraitChinese26
    else if keyboardType == "chinese" && orientation == "landscape" then self.landscapeChinese26
    else if keyboardType == "english" && orientation == "portrait" then self.portraitEnglish26
    else if keyboardType == "english" && orientation == "landscape" then self.landscapeEnglish26
    else self.portraitChinese26,
}
