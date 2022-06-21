Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65A5C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 02:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344131AbiFUCaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 22:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242831AbiFUCaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 22:30:16 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1B518E24;
        Mon, 20 Jun 2022 19:30:15 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A9042012C0;
        Tue, 21 Jun 2022 04:30:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E3122012A8;
        Tue, 21 Jun 2022 04:30:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 718FC1802183;
        Tue, 21 Jun 2022 10:30:12 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     shengjiu.wang@gmail.com
Subject: [PATCH v3 0/3] add bt-sco sound card support for i.MX8MQ/MM/MN
Date:   Tue, 21 Jun 2022 10:16:00 +0800
Message-Id: <1655777763-21153-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add bt-sco sound card support for i.MX8MQ/MM/MN

changes in v3:
- move compatible property to be first

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

