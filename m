Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A01DC3527B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 15:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350896AbiDAPAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349154AbiDAOph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:45:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D41299A46;
        Fri,  1 Apr 2022 07:35:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDC02B82507;
        Fri,  1 Apr 2022 14:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE838C340EE;
        Fri,  1 Apr 2022 14:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648823722;
        bh=BajCV1XP1yu2fNsxTPAu527PA7vDUg5dFLjTlsjP+bE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aT3bb40XXxiWlHGpQ9NUrhwFsSGWNzN8ZbPumib98ieuDO6gkGtSIVnDlMFeZil9e
         j3KdW2XcRGlYqCnoj1bj1z6tBzMP8xvNkJsnuX7ULwFUNhFSu1DFWU8axDW1jF2whv
         pTLdo7Ga2VViksu6NdeheqClTrWDib9SdFNx9Hhz3QFtv3A01D6UeEOaeMYfVqSmlI
         7HTcmbr56FOw9s4DPX8DNOPQg0D8+/zkNA7tGTVp6Dd83K70mymovgYKdq0YPCAybp
         /EPmyPDdTJeeVx9uhGxb3MhG28/J9tE4eTSIBxDB3FwYlfsWjLBCfIXrbe9pbggsfn
         8+9HRmTS1TiDg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, balbi@kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 052/109] usb: dwc3: pci: Set the swnode from inside dwc3_pci_quirks()
Date:   Fri,  1 Apr 2022 10:31:59 -0400
Message-Id: <20220401143256.1950537-52-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401143256.1950537-1-sashal@kernel.org>
References: <20220401143256.1950537-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit e285cb403994419e997749c9a52b9370884ae0c8 ]

The quirk handling may need to set some different properties
which means using a different swnode, move the setting of the swnode
to inside dwc3_pci_quirks() so that the quirk handling can choose
a different swnode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20220213130524.18748-4-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-pci.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 06d0e88ec8af..4d9608cc55f7 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -185,7 +185,8 @@ static const struct software_node dwc3_pci_amd_mr_swnode = {
 	.properties = dwc3_pci_mr_properties,
 };
 
-static int dwc3_pci_quirks(struct dwc3_pci *dwc)
+static int dwc3_pci_quirks(struct dwc3_pci *dwc,
+			   const struct software_node *swnode)
 {
 	struct pci_dev			*pdev = dwc->pci;
 
@@ -242,7 +243,7 @@ static int dwc3_pci_quirks(struct dwc3_pci *dwc)
 		}
 	}
 
-	return 0;
+	return device_add_software_node(&dwc->dwc3->dev, swnode);
 }
 
 #ifdef CONFIG_PM
@@ -307,11 +308,7 @@ static int dwc3_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	dwc->dwc3->dev.parent = dev;
 	ACPI_COMPANION_SET(&dwc->dwc3->dev, ACPI_COMPANION(dev));
 
-	ret = device_add_software_node(&dwc->dwc3->dev, (void *)id->driver_data);
-	if (ret < 0)
-		goto err;
-
-	ret = dwc3_pci_quirks(dwc);
+	ret = dwc3_pci_quirks(dwc, (void *)id->driver_data);
 	if (ret)
 		goto err;
 
-- 
2.34.1

