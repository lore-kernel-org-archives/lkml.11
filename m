Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80589C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 10:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiDMKUr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 06:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiDMKUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:20:40 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1288F57165;
        Wed, 13 Apr 2022 03:18:18 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 23DA5ud1006811;
        Wed, 13 Apr 2022 18:05:56 +0800 (GMT-8)
        (envelope-from ryan_chen@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 13 Apr
 2022 18:17:40 +0800
From:   ryan_chen <ryan_chen@aspeedtech.com>
To:     ryan_chen <ryan_chen@aspeedtech.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bmc-sw@aspeedtech.com>
Subject: [PATCH v2 0/3] Add ASPEED AST2600 I2C new controller driver
Date:   Wed, 13 Apr 2022 18:17:32 +0800
Message-ID: <20220413101735.27678-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 23DA5ud1006811
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add AST2600 i2c new register set driver. The i2c new
register set have new clock divider option for more flexiable generation.
And also have separate i2c master and slave register set for control.

v2:
-add i2c global ymal file commit
-rename file name from new to ast2600.
 aspeed-i2c-new-global.c -> i2c-ast2600-global.c
 aspeed-i2c-new-global.h -> i2c-ast2600-global.h
 i2c-new-aspeed.c -> i2c-ast2600.c
-rename all driver function name to ast2600

ryan_chen (3):
  dt-bindings: i2c-ast2600: Add bindings for AST2600 i2C global register
    controller
  dt-bindings: i2c-ast2600: Add bindings for AST2600 i2C driver
  i2c:aspeed:support ast2600 i2c new register mode driver

 .../i2c/aspeed,i2c-ast2600-global.ymal        |   44 +
 .../bindings/i2c/aspeed,i2c-ast2600.ymal      |   78 +
 drivers/i2c/busses/Kconfig                    |   11 +
 drivers/i2c/busses/Makefile                   |    1 +
 drivers/i2c/busses/i2c-ast2600-global.c       |   94 +
 drivers/i2c/busses/i2c-ast2600-global.h       |   19 +
 drivers/i2c/busses/i2c-ast2600.c              | 1706 +++++++++++++++++
 7 files changed, 1953 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600-global.ymal
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.ymal
 create mode 100644 drivers/i2c/busses/i2c-ast2600-global.c
 create mode 100644 drivers/i2c/busses/i2c-ast2600-global.h
 create mode 100644 drivers/i2c/busses/i2c-ast2600.c

-- 
2.17.1

