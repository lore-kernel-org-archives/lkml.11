Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866EFC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 12:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350693AbiFUM4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 08:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240281AbiFUM42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:56:28 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jun 2022 05:56:27 PDT
Received: from mellanox.co.il (mail-il-dmz.mellanox.com [193.47.165.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 469C313FAD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:56:26 -0700 (PDT)
Received: from Internal Mail-Server by MTLPINE1 (envelope-from asmaa@mellanox.com)
        with SMTP; 21 Jun 2022 15:49:41 +0300
Received: from bu-vnc02.mtbu.labs.mlnx (bu-vnc02.mtbu.labs.mlnx [10.15.2.65])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 25LCneLV012801;
        Tue, 21 Jun 2022 08:49:40 -0400
Received: (from asmaa@localhost)
        by bu-vnc02.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 25LCndIU023883;
        Tue, 21 Jun 2022 08:49:39 -0400
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     sebastian.reichel@collabora.com, sre@kernel.org,
        linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org
Cc:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v1 1/1] linux-next: Fix build failure in pwr-mlxbf.c
Date:   Tue, 21 Jun 2022 08:49:30 -0400
Message-Id: <20220621124930.23758-1-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The build failure is at line 67: implicit declaration of
function 'devm_work_autocancel'.
So declare library for devm_work_autocancel.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/power/reset/pwr-mlxbf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/pwr-mlxbf.c b/drivers/power/reset/pwr-mlxbf.c
index c1f9987834a2..1c4904c0e1f5 100644
--- a/drivers/power/reset/pwr-mlxbf.c
+++ b/drivers/power/reset/pwr-mlxbf.c
@@ -6,6 +6,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/devm-helpers.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
-- 
2.30.1

