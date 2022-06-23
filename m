Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F587C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 20:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiFWUmc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 16:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiFWUmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:42:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F886271D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20F5BB82545
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2536BC341C6;
        Thu, 23 Jun 2022 20:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656016940;
        bh=y98OLdtcNvpcDXEjtnWY2UhmrE4/lxEJep44+yAaslg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OwsphsYIeoBNldq4JXo+FvuAeN2cEokrT5dSan9+RlSy8gMC2fFq2ykQo6Hrnc9ZG
         r712Z2J63PKNcn6rclRlo40U6r1xsnend+RFlHC8cSzHi78ml3cwrQ53oB0y7imbg5
         2/UJ+dd7p99iJWLUjWjkAXkeyxB74z2gcTQciNDkK1xCzsC5jA2KPRtN32IJvo/u3k
         BIffUXXSHUp9aoy5+vLDchpqibC0pJbi+4D5bdOiFsWXTn9YRGSpe6UvyHJ1/P1iJB
         ahQmgOBIgcSwHANKL3Ln7KwnRmCS2dyhD8HzDjoXuuwNALI8XrB3MdSzAXDCCLwAO8
         LLTOLGerE6HEA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 4/9] habanalabs: print if firmware is secured during load
Date:   Thu, 23 Jun 2022 23:42:07 +0300
Message-Id: <20220623204212.1628709-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623204212.1628709-1-ogabbay@kernel.org>
References: <20220623204212.1628709-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

For easier debug, it is desirable to have a simple way
to know whether the device is secured or not, hence we dump this
indication during boot.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index bd66e4f84156..42dfbfff92fd 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -2425,7 +2425,8 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 	int rc;
 
 	dev_info(hdev->dev,
-		"Loading firmware to device, may take some time...\n");
+		"Loading %sfirmware to device, may take some time...\n",
+		hdev->asic_prop.fw_security_enabled ? "secured " : "");
 
 	/* initialize FW descriptor as invalid */
 	fw_loader->dynamic_loader.fw_desc_valid = false;
-- 
2.25.1

