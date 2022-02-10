Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696DAC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 20:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344420AbiBJUxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 15:53:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242216AbiBJUxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 15:53:42 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652111034
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 12:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644526423; x=1676062423;
  h=from:to:cc:subject:date:message-id;
  bh=jsiMHNGnwK5aOfnfdJPXvi+L/dETJi4cf0IWcHr0ezM=;
  b=fyZzd6//SwEeMAJ5amWLQKKiORYb8qofnPerweMDEWrnynCV/PdkaNa8
   JPejTfi5GhwQUKxJEF89EJAVtrTvvlJLWF1qBEBEWyj7z2mFZvUp+utzD
   WoZKCyYxg+s5AVfqK2vD6lyAgY7T1EhXuad5/8DW7pfEpGfASnPndGRxr
   c=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 10 Feb 2022 12:53:43 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Feb 2022 12:53:41 -0800
X-QCInternal: smtphost
Received: from maggarwa.ap.qualcomm.com (HELO nitirawa-linux.qualcomm.com) ([10.206.25.176])
  by ironmsg01-blr.qualcomm.com with ESMTP; 11 Feb 2022 02:23:31 +0530
Received: by nitirawa-linux.qualcomm.com (Postfix, from userid 2342877)
        id 5D1903B6F; Fri, 11 Feb 2022 02:23:30 +0530 (IST)
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nitin Rawat <quic_nitirawa@quicinc.com>,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Date:   Fri, 11 Feb 2022 02:23:28 +0530
Message-Id: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable quick suspend quirks for Sc7280 platform, where power
to nvme device is removed during suspend-resume process. This
is done to avoid the failure dring resume.

This enables simple suspend path for this platform.

Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
---

Change from v2-v3:
* changed if/else condition

---

 drivers/nvme/host/pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed6..1dff749 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3034,6 +3034,15 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 			return NVME_QUIRK_SIMPLE_SUSPEND;
 	}

+	if (of_machine_is_compatible("qcom,sc7280")) {
+		/*
+		 * Append quick suspend quirks for sc7280 platforms
+		 * so that simple suspend path is executed for this
+		 * platform to avoid any resume failure.
+		 */
+		return NVME_QUIRK_SIMPLE_SUSPEND;
+	}
+
 	return 0;
 }

--
2.7.4

