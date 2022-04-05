Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25318C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 09:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243141AbiDEJIs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239413AbiDEIUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:20:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2495A6E376;
        Tue,  5 Apr 2022 01:12:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3DCE609D0;
        Tue,  5 Apr 2022 08:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A5CC385A1;
        Tue,  5 Apr 2022 08:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649146369;
        bh=LJJehfXe2pxzDjwyzAOhqxPzhzKLcJEjYz+g1v9YVeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IFin/vo9uwu+WTKIxeav1bEbfXJjS+GFiHjB0AXItubJSt/KX2ooaZenYGYfO+UPE
         CnW8dLRK+9+/LHMttzOHH4KnzfHdZ9NLZGGjOPkdBc0BENGdM3jVjpEJOAW1xEwjFd
         V887ybRtkS26mjM5ojloLON2bBYgxUbCQdGdrb0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Oded Gabbay <ogabbay@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0739/1126] habanalabs: Add check for pci_enable_device
Date:   Tue,  5 Apr 2022 09:24:46 +0200
Message-Id: <20220405070429.278835914@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit 9c27896ac1bb83ea5c461ce6f7089d02102a2b21 ]

As the potential failure of the pci_enable_device(),
it should be better to check the return value and return
error if fails.

Fixes: 70b2f993ea4a ("habanalabs: create common folder")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/habanalabs/common/debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index fc084ee5106e..09001fd9db85 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -890,6 +890,8 @@ static ssize_t hl_set_power_state(struct file *f, const char __user *buf,
 		pci_set_power_state(hdev->pdev, PCI_D0);
 		pci_restore_state(hdev->pdev);
 		rc = pci_enable_device(hdev->pdev);
+		if (rc < 0)
+			return rc;
 	} else if (value == 2) {
 		pci_save_state(hdev->pdev);
 		pci_disable_device(hdev->pdev);
-- 
2.34.1



