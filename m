Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECB7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 01:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiFHBls (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383691AbiFGWGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:06:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D50625149E;
        Tue,  7 Jun 2022 12:16:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DDBCB823CB;
        Tue,  7 Jun 2022 19:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68634C385A5;
        Tue,  7 Jun 2022 19:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654629416;
        bh=3OcrHuuslHJW746sRgbFrkTfkh1EDYsMyRzBnULldjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u3xW9WvgoZewDusOTVXBxRj0vyg/TckyTq1Disee3oE2rR7BxwTBwEMb4X2JEN9kD
         3oaN7rRJZOiuLlMh3n3O8Lf9dEMQL9c9N7OxjKfldNjIMVGTW58pFco2ytoH2A3SFB
         uVd6o0sYPpqcfVURReyJKJJzESV9Xzuk/yGgnhw8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 684/879] video: fbdev: clcdfb: Fix refcount leak in clcdfb_of_vram_setup
Date:   Tue,  7 Jun 2022 19:03:22 +0200
Message-Id: <20220607165022.699420106@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607165002.659942637@linuxfoundation.org>
References: <20220607165002.659942637@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit b23789a59fa6f00e98a319291819f91fbba0deb8 ]

of_parse_phandle() returns a node pointer with refcount incremented, we should
use of_node_put() on it when not need anymore.  Add missing of_node_put() to
avoid refcount leak.

Fixes: d10715be03bd ("video: ARM CLCD: Add DT support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/amba-clcd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index 9ec969e136bf..8080116aea84 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -758,12 +758,15 @@ static int clcdfb_of_vram_setup(struct clcd_fb *fb)
 		return -ENODEV;
 
 	fb->fb.screen_base = of_iomap(memory, 0);
-	if (!fb->fb.screen_base)
+	if (!fb->fb.screen_base) {
+		of_node_put(memory);
 		return -ENOMEM;
+	}
 
 	fb->fb.fix.smem_start = of_translate_address(memory,
 			of_get_address(memory, 0, &size, NULL));
 	fb->fb.fix.smem_len = size;
+	of_node_put(memory);
 
 	return 0;
 }
-- 
2.35.1



