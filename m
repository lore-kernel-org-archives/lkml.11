Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC72C3527A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 11:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359637AbiDELUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbiDEIQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:16:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8557092D;
        Tue,  5 Apr 2022 01:04:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE9CDB81B9C;
        Tue,  5 Apr 2022 08:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BDAC385A0;
        Tue,  5 Apr 2022 08:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649145833;
        bh=fCRnFLF8zwtu51VJX15c89qRwAQ61q0ACsOM/VyssFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZqAZFxT2edDh/HPyK8yBUfMmLqd5hcXJ3VCL/ewHuJUWWpJpX7RmmtM7jAxkipwib
         L2wl+FH4WeYXhU18NojSR9eGap9bIbDK1tywItAbAAwOedgOr9e4F6ASmbhWNz42o2
         +A/XxBoeQ7qeidU2LBbL1U6hWeFvQYms1fw+mFsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0509/1126] mt76: mt7915: fix the nss setting in bitrates
Date:   Tue,  5 Apr 2022 09:20:56 +0200
Message-Id: <20220405070422.568385584@linuxfoundation.org>
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

From: MeiChia Chiu <meichia.chiu@mediatek.com>

[ Upstream commit c41d2a075206fcbdc89695b874a6ac06160b4f1a ]

without this change, the fixed MCS only supports 1 Nss.

Fixes: 70fd1333cd32f ("mt76: mt7915: rework .set_bitrate_mask() to support more options")
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index f7b97b7ab21f..8ff2402c4817 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2126,9 +2126,12 @@ mt7915_mcu_add_rate_ctrl_fixed(struct mt7915_dev *dev,
 			phy.sgi |= gi << (i << (_he));				\
 			phy.he_ltf |= mask->control[band].he_ltf << (i << (_he));\
 		}								\
-		for (i = 0; i < ARRAY_SIZE(mask->control[band]._mcs); i++) 	\
-			nrates += hweight16(mask->control[band]._mcs[i]);  	\
-		phy.mcs = ffs(mask->control[band]._mcs[0]) - 1;			\
+		for (i = 0; i < ARRAY_SIZE(mask->control[band]._mcs); i++) {	\
+			if (!mask->control[band]._mcs[i])			\
+				continue;					\
+			nrates += hweight16(mask->control[band]._mcs[i]);	\
+			phy.mcs = ffs(mask->control[band]._mcs[i]) - 1;		\
+		}								\
 	} while (0)
 
 	if (sta->he_cap.has_he) {
-- 
2.34.1



