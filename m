Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3DDC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 11:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355025AbiFMLhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 07:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354664AbiFML3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 07:29:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558172AC76;
        Mon, 13 Jun 2022 03:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD2D961252;
        Mon, 13 Jun 2022 10:45:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB392C34114;
        Mon, 13 Jun 2022 10:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655117121;
        bh=OMj39jS06hxaG1nDHlRURp1yNmU2OPNlfpnor1SiATM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t72lEPFGCYilfLBZZ4NM6mefe/xaztGU1cCN9RNzmsfDCqn0HavrFuFvHo+Wn0KDl
         o0sLvE7u2+fSZN//JT+jeSAWX/BF63hfvm8AQApjcx52qIYVcgsCqnwWNPG/Hlw1jy
         p4MUm2nTOxj7CFvGJA1GMR6l9Kf7ZDO/QHcKDElQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zheng Yongjun <zhengyongjun3@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 294/411] usb: dwc3: pci: Fix pm_runtime_get_sync() error checking
Date:   Mon, 13 Jun 2022 12:09:27 +0200
Message-Id: <20220613094937.574792706@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220613094928.482772422@linuxfoundation.org>
References: <20220613094928.482772422@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Yongjun <zhengyongjun3@huawei.com>

[ Upstream commit a03e2ddab8e735e2cc315609b297b300e9cc60d2 ]

If the device is already in a runtime PM enabled state
pm_runtime_get_sync() will return 1, so a test for negative
value should be used to check for errors.

Fixes: 8eed00b237a28 ("usb: dwc3: pci: Runtime resume child device from wq")
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Link: https://lore.kernel.org/r/20220422062652.10575-1-zhengyongjun3@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 99964f96ff74..955bf820f410 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -211,7 +211,7 @@ static void dwc3_pci_resume_work(struct work_struct *work)
 	int ret;
 
 	ret = pm_runtime_get_sync(&dwc3->dev);
-	if (ret) {
+	if (ret < 0) {
 		pm_runtime_put_sync_autosuspend(&dwc3->dev);
 		return;
 	}
-- 
2.35.1



