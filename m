Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFBCC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 02:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbiFTChp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jun 2022 22:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiFTChn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 22:37:43 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC28B1F2;
        Sun, 19 Jun 2022 19:37:42 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D97820061A;
        Mon, 20 Jun 2022 04:37:41 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 02E15200609;
        Mon, 20 Jun 2022 04:37:41 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C9D741802183;
        Mon, 20 Jun 2022 10:37:39 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     shengjiu.wang@gmail.com
Subject: [PATCH v2 0/3] add bt-sco sound card support for i.MX8MQ/MM/MN
Date:   Mon, 20 Jun 2022 10:23:30 +0800
Message-Id: <1655691813-19878-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add bt-sco sound card support for i.MX8MQ/MM/MN

changes in v2
- update note name of bt-sco codec

Shengjiu Wang (3):
  arm64: dts: imx8mm-evk: add bt-sco sound card support
  arm64: dts: imx8mq-evk: add bt-sco sound card support
  arm64: dts: imx8mn-evk: add bt-sco sound card support

 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 43 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 43 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts  | 43 +++++++++++++++++++
 3 files changed, 129 insertions(+)

-- 
2.17.1

