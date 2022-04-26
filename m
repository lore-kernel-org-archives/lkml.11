Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B25C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 08:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244572AbiDZIxS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 04:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345332AbiDZIim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:38:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C27939C7;
        Tue, 26 Apr 2022 01:29:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7459F6183D;
        Tue, 26 Apr 2022 08:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80788C385A4;
        Tue, 26 Apr 2022 08:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650961773;
        bh=kJ2xY2WZgC5zmpjwAqT8+oSDGHDnpl9nTFmzZW9q5wU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBwW2xxIss/1imXiwKwtHV6rxQqKQR9wkQFcXVP+CFwqFbVKgbwNdvIV4qtnA4MPI
         vWa0Mwbew/BhZt8dGNgf+KzjfiVs3ZJt8Mv+IPyPfGPsdrsqdnuTa2jwargXAwtPFx
         v0XZBSMAVQampl8fiRshCtIchkjGbROdEg/RVv5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 25/62] platform/x86: samsung-laptop: Fix an unsigned comparison which can never be negative
Date:   Tue, 26 Apr 2022 10:21:05 +0200
Message-Id: <20220426081737.949185157@linuxfoundation.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426081737.209637816@linuxfoundation.org>
References: <20220426081737.209637816@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

[ Upstream commit 0284d4d1be753f648f28b77bdfbe6a959212af5c ]

Eliminate the follow smatch warnings:

drivers/platform/x86/samsung-laptop.c:1124 kbd_led_set() warn: unsigned
'value' is never less than zero.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Link: https://lore.kernel.org/r/20220322061830.105579-1-jiapeng.chong@linux.alibaba.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/samsung-laptop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/x86/samsung-laptop.c b/drivers/platform/x86/samsung-laptop.c
index 9b6a93ff41ff..91e468fcaf7c 100644
--- a/drivers/platform/x86/samsung-laptop.c
+++ b/drivers/platform/x86/samsung-laptop.c
@@ -1121,8 +1121,6 @@ static void kbd_led_set(struct led_classdev *led_cdev,
 
 	if (value > samsung->kbd_led.max_brightness)
 		value = samsung->kbd_led.max_brightness;
-	else if (value < 0)
-		value = 0;
 
 	samsung->kbd_led_wk = value;
 	queue_work(samsung->led_workqueue, &samsung->kbd_led_work);
-- 
2.35.1



