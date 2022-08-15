Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44039C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 23:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343890AbiHOXRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 19:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345701AbiHOXO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 19:14:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEE579EFB;
        Mon, 15 Aug 2022 13:01:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87BF5612B9;
        Mon, 15 Aug 2022 20:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AEDC433C1;
        Mon, 15 Aug 2022 20:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660593693;
        bh=abu+AWRH5S6uTZkEhznvw+0Ogzufh67MHgGaXOOZzbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1oDmmkCbXl8yvNsUtxuLcM/bXPXmmqW26StG52cGK6pZGupQT8ImlS+wpgb0eCvrj
         MVW45KMvcw4lJEg3pYH1AcuUzgIkP9NHb87M1vQNcTbmK7dXLytuhcNP6mAKcyu6lt
         B8zQcy0TB1+ltEvEwM9FlVISZCWP52sM3idMbY5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stanley Chu <stanley.chu@mediatek.com>,
        Peter Wang <peter.wang@mediatek.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.18 0959/1095] scsi: ufs: core: Correct ufshcd_shutdown() flow
Date:   Mon, 15 Aug 2022 20:05:58 +0200
Message-Id: <20220815180508.745559584@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180429.240518113@linuxfoundation.org>
References: <20220815180429.240518113@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Wang <peter.wang@mediatek.com>

commit 00511d2abf5708ad05dd5d1c36adb2468d274698 upstream.

After ufshcd_wl_shutdown() set device power off and link off,
ufshcd_shutdown() could turn off clock/power. Also remove
pm_runtime_get_sync.

The reason why it is safe to remove pm_runtime_get_sync() is because:

 - ufshcd_wl_shutdown() -> pm_runtime_get_sync() will resume hba->dev too.

 - device resume(turn on clk/power) is not required, even if device is in
   RPM_SUSPENDED.

Link: https://lore.kernel.org/r/20220727030526.31022-1-peter.wang@mediatek.com
Fixes: b294ff3e3449 ("scsi: ufs: core: Enable power management for wlun")
Cc: <stable@vger.kernel.org> # 5.15.x
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Signed-off-by: Peter Wang <peter.wang@mediatek.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ufs/ufshcd.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -9500,12 +9500,8 @@ EXPORT_SYMBOL(ufshcd_runtime_resume);
 int ufshcd_shutdown(struct ufs_hba *hba)
 {
 	if (ufshcd_is_ufs_dev_poweroff(hba) && ufshcd_is_link_off(hba))
-		goto out;
+		ufshcd_suspend(hba);
 
-	pm_runtime_get_sync(hba->dev);
-
-	ufshcd_suspend(hba);
-out:
 	hba->is_powered = false;
 	/* allow force shutdown even in case of errors */
 	return 0;


