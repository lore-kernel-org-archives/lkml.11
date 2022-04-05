Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D22DC47081
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 08:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbiDEIqP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 04:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiDEIGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:06:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F6069CC4;
        Tue,  5 Apr 2022 01:01:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C868617BD;
        Tue,  5 Apr 2022 08:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5D5C385A0;
        Tue,  5 Apr 2022 08:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649145703;
        bh=M07nTir5uJAh2RXjL2uD9Y/H2ywZv65EE3UFaYDtTiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m0euoDSbFlqPyl96lUGglJkXS6IQxr2g18kmurEHCymdCh75jCOIn8IC/2pw9bzTX
         gIXd+NP0c7ubjgHuoNRT18MY1NG8q/DKF3IXmFPfZsQ+VLsL3otMN6TjMEhrIxDUK+
         bwWrlU8FyaZOlHWYMN/oh7BQLfkI83+somY+ReW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0498/1126] mt76: mt7921: fix a leftover race in runtime-pm
Date:   Tue,  5 Apr 2022 09:20:45 +0200
Message-Id: <20220405070422.244519556@linuxfoundation.org>
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

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 591cdccebdd4d02eb46d400dea911136400cc567 ]

Fix a possible race in mt7921_pm_power_save_work() if rx/tx napi
schedules ps_work and we are currently accessing device register
on a different cpu.

Fixes: 1d8efc741df8 ("mt76: mt7921: introduce Runtime PM support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index ec10f95a4649..3e83a0c33143 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1551,6 +1551,14 @@ void mt7921_pm_power_save_work(struct work_struct *work)
 	    test_bit(MT76_HW_SCHED_SCANNING, &mphy->state))
 		goto out;
 
+	if (mutex_is_locked(&dev->mt76.mutex))
+		/* if mt76 mutex is held we should not put the device
+		 * to sleep since we are currently accessing device
+		 * register map. We need to wait for the next power_save
+		 * trigger.
+		 */
+		goto out;
+
 	if (time_is_after_jiffies(dev->pm.last_activity + delta)) {
 		delta = dev->pm.last_activity + delta - jiffies;
 		goto out;
-- 
2.34.1



