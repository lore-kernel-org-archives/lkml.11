Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37480C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 13:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354111AbiDONpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 09:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbiDONo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:44:57 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4E843389;
        Fri, 15 Apr 2022 06:42:29 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23FDgR9x128832;
        Fri, 15 Apr 2022 08:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650030147;
        bh=ijQrP5XfHZn4TmCcFge6Wg+R2+udXFBDZkxgCKeVqqs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qUk/NaT6gn9O29ORYUO4ZnCXoJDVPxJHJp36PwFqVii6ZkrG8HUd3ncPEFYHGdhLL
         crDkuVkzcuZC+/d9KQa1KEVHvsFFL96sgXUGaFLjg1cykzSSfKvFa1AP1qWwrv4KgD
         BNfCQcGJ9rcPJKrMsv8KT1bTwN7hKskQwfZhpEDk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23FDgQA2012575
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Apr 2022 08:42:26 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 15
 Apr 2022 08:42:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 15 Apr 2022 08:42:26 -0500
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23FDgEjh022953;
        Fri, 15 Apr 2022 08:42:21 -0500
From:   Georgi Vlaev <g-vlaev@ti.com>
To:     <ssantosh@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <nm@ti.com>,
        Georgi Vlaev <g-vlaev@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 1/2] clk: keystone: syscon-clk: Add support for AM62 epwm-tbclk
Date:   Fri, 15 Apr 2022 16:41:41 +0300
Message-ID: <20220415134142.12141-2-g-vlaev@ti.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220415134142.12141-1-g-vlaev@ti.com>
References: <20220415134142.12141-1-g-vlaev@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM62 has 3 instances of EPWM modules. Each EPWM module has
an EPWM TBCLKEN module input used to individually enable or
disable its EPWM time-base clock. The EPWM time-base clock
enable input comes from the CTRLMMR_EPWM_TB_CLKEN register
bits 0 to 2 in CTRL_MMR0 module (6.1.1.4.1.48 [1]). This
is virtually the same setup as in AM64 but with 3 instead
of 9 clock providers on AM62.

Update the driver with the 3 instances of clocks associated
to a new compatible: "ti,am62-epwm-tbclk".

[1] https://www.ti.com/lit/pdf/spruiv7

Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
Tested-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/clk/keystone/syscon-clk.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/clk/keystone/syscon-clk.c b/drivers/clk/keystone/syscon-clk.c
index aae1a4076281..19198325b909 100644
--- a/drivers/clk/keystone/syscon-clk.c
+++ b/drivers/clk/keystone/syscon-clk.c
@@ -162,6 +162,13 @@ static const struct ti_syscon_gate_clk_data am64_clk_data[] = {
 	{ /* Sentinel */ },
 };
 
+static const struct ti_syscon_gate_clk_data am62_clk_data[] = {
+	TI_SYSCON_CLK_GATE("epwm_tbclk0", 0x0, 0),
+	TI_SYSCON_CLK_GATE("epwm_tbclk1", 0x0, 1),
+	TI_SYSCON_CLK_GATE("epwm_tbclk2", 0x0, 2),
+	{ /* Sentinel */ },
+};
+
 static const struct of_device_id ti_syscon_gate_clk_ids[] = {
 	{
 		.compatible = "ti,am654-ehrpwm-tbclk",
@@ -171,6 +178,10 @@ static const struct of_device_id ti_syscon_gate_clk_ids[] = {
 		.compatible = "ti,am64-epwm-tbclk",
 		.data = &am64_clk_data,
 	},
+	{
+		.compatible = "ti,am62-epwm-tbclk",
+		.data = &am62_clk_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ti_syscon_gate_clk_ids);
-- 
2.30.2

