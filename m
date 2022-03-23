Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDCEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 00:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbiCWAnE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 20:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiCWAnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:43:00 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F305E77D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 17:41:30 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 22N0Thp7001180;
        Wed, 23 Mar 2022 08:29:43 +0800 (GMT-8)
        (envelope-from ryan_chen@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Mar
 2022 08:40:15 +0800
From:   ryan_chen <ryan_chen@aspeedtech.com>
To:     <BMC-SW@aspeedtech.com>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add ASPEED AST2600 I2C new controller driver
Date:   Wed, 23 Mar 2022 08:40:07 +0800
Message-ID: <20220323004009.943298-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 22N0Thp7001180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add AST2600 i2c new register mode driver. The 
i2c new register mode have new clock divider option for
more flexibale generation. And also have separate i2c 
master and slave register set for control.

ryan_chen (2):
  dt-bindings: i2c-new: Add bindings for AST2600 i2C new controller
  i2c:aspeed:support ast2600 i2c new register mode driver

 .../bindings/i2c/aspeed,i2c-new.yaml          |   78 +
 drivers/i2c/busses/Kconfig                    |   11 +
 drivers/i2c/busses/Makefile                   |    1 +
 drivers/i2c/busses/aspeed-i2c-new-global.c    |   91 +
 drivers/i2c/busses/aspeed-i2c-new-global.h    |   19 +
 drivers/i2c/busses/i2c-new-aspeed.c           | 1698 +++++++++++++++++
 6 files changed, 1898 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/aspeed,i2c-new.yaml
 create mode 100644 drivers/i2c/busses/aspeed-i2c-new-global.c
 create mode 100644 drivers/i2c/busses/aspeed-i2c-new-global.h
 create mode 100644 drivers/i2c/busses/i2c-new-aspeed.c

-- 
2.25.1

