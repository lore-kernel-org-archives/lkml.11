Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2724C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 10:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355905AbiHWKsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356315AbiHWKlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:41:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EA18605C;
        Tue, 23 Aug 2022 02:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A5116069D;
        Tue, 23 Aug 2022 09:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F9FC433D6;
        Tue, 23 Aug 2022 09:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661245762;
        bh=Lveu6uFlMWa/CVBVxi5kfsSkEcxc8ilbail2ZMSOKDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DCYLo3LSCkSEZSULbgNLbnAaZ0drbiiU8c1Fyh4GXajFijLfWjabKwzR+d9s7A1Sm
         YvIcPwB5Q1+wqKiStoI+zIrm5nh75w6RpT87YJzv1GFtw8WmQVlw25LV9Xjl27JBr9
         4qMP29Gjov3Ieic74hxzusXfG+kC+rOfMHQK9D0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 182/287] video: fbdev: arkfb: Check the size of screen before memset_io()
Date:   Tue, 23 Aug 2022 10:25:51 +0200
Message-Id: <20220823080106.912266749@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080100.268827165@linuxfoundation.org>
References: <20220823080100.268827165@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheyu Ma <zheyuma97@gmail.com>

[ Upstream commit 96b550971c65d54d64728d8ba973487878a06454 ]

In the function arkfb_set_par(), the value of 'screen_size' is
calculated by the user input. If the user provides the improper value,
the value of 'screen_size' may larger than 'info->screen_size', which
may cause the following bug:

[  659.399066] BUG: unable to handle page fault for address: ffffc90003000000
[  659.399077] #PF: supervisor write access in kernel mode
[  659.399079] #PF: error_code(0x0002) - not-present page
[  659.399094] RIP: 0010:memset_orig+0x33/0xb0
[  659.399116] Call Trace:
[  659.399122]  arkfb_set_par+0x143f/0x24c0
[  659.399130]  fb_set_var+0x604/0xeb0
[  659.399161]  do_fb_ioctl+0x234/0x670
[  659.399189]  fb_ioctl+0xdd/0x130

Fix the this by checking the value of 'screen_size' before memset_io().

Fixes: 681e14730c73 ("arkfb: new framebuffer driver for ARK Logic cards")
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/arkfb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
index bfa221b68d71..f7920987dd24 100644
--- a/drivers/video/fbdev/arkfb.c
+++ b/drivers/video/fbdev/arkfb.c
@@ -794,6 +794,8 @@ static int arkfb_set_par(struct fb_info *info)
 	value = ((value * hmul / hdiv) / 8) - 5;
 	vga_wcrt(par->state.vgabase, 0x42, (value + 1) / 2);
 
+	if (screen_size > info->screen_size)
+		screen_size = info->screen_size;
 	memset_io(info->screen_base, 0x00, screen_size);
 	/* Device and screen back on */
 	svga_wcrt_mask(par->state.vgabase, 0x17, 0x80, 0x80);
-- 
2.35.1



