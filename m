Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D923DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 12:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbiCRMnI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 08:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbiCRMmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:42:47 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D092E35A0;
        Fri, 18 Mar 2022 05:41:29 -0700 (PDT)
Received: from droid11-sz.amlogic.com (10.28.8.21) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Fri, 18 Mar 2022
 20:41:26 +0800
From:   Liang Yang <liang.yang@amlogic.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-mtd@lists.infradead.org>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/2] refine the NFC clock framework
Date:   Fri, 18 Mar 2022 20:41:18 +0800
Message-ID: <20220318124121.26117-1-liang.yang@amlogic.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.21]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Background firstly, 
Both EMMC and NAND have the same clock control register named 'SD_EMMC_CLOCK' which is
defined in EMMC port internally. bit0~5 of 'SD_EMMC_CLOCK' is the divider and
bit6~7 is the mux for fix pll and xtal.
Previously a common MMC sub clock framework is implemented and shared by EMMC and
NAND, but that is coupling the EMMC and NAND, although EMMC and NAND is mutually
exclusive. see the link:
[https://lore.kernel.org/all/1jy23226sa.fsf@starbuckisacylon.baylibre.com/]
Now we plan to abandon common mmc sub clock framework and recovery the series.

Changes since v2 [3]
 - use fw_name from dts, instead the wrong way using __clk_get_name
 - reg resource size change to 0x800
 - use reg-names

Changes since v1 [2]
 - use clk_parent_data instead of parent_names
 - define a reg resource instead of sd_emmc_c_clkc 

[1] https://lore.kernel.org/r/20220106033130.37623-1-liang.yang@amlogic.com
    https://lore.kernel.org/r/20220106032504.23310-1-liang.yang@amlogic.com
[2] https://lore.kernel.org/all/20220217063346.21691-1-liang.yang@amlogic.com

Liang Yang (2):
  mtd: rawnand: meson: discard the common MMC sub clock framework
  dt-bindings: nand: meson: refine Amlogic NAND controller driver

 .../bindings/mtd/amlogic,meson-nand.txt       |  60 -----------
 .../bindings/mtd/amlogic,meson-nand.yaml      |  71 ++++++++++++
 drivers/mtd/nand/raw/meson_nand.c             | 101 +++++++++---------
 3 files changed, 124 insertions(+), 108 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml

-- 
2.34.1

