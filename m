Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D8EC32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 08:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243325AbiHWI3K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 04:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243628AbiHWIZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:25:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E426FA3E;
        Tue, 23 Aug 2022 01:13:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D0F56129A;
        Tue, 23 Aug 2022 08:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FCCC433D7;
        Tue, 23 Aug 2022 08:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661242397;
        bh=mLBY6Fsf6WZ2u0NsCDFnW8EU6G375hSpNr7EVGFAr1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Okg3i6g0mxpnReqEbzhLb2dmMg5iG+qw9kc+AqO+u1uk71gs5ZLILKX4TCJ8/ZU2f
         /lF1jbm9r+ViLZA6vtHEuXAyC30JWn61ABWJhPL5yZ7JZRm/39MHeEM9yzZrXRj20A
         GH8/bI+jwjXhOWd8CYKl5EWE+GEip6cpNpincS9M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.19 109/365] Input: iqs7222 - remove support for RF filter
Date:   Tue, 23 Aug 2022 10:00:10 +0200
Message-Id: <20220823080122.758836359@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080118.128342613@linuxfoundation.org>
References: <20220823080118.128342613@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff LaBundy <jeff@labundy.com>

commit 381932cf61d52bde656c8596c0cb8f46bed53dc0 upstream.

The vendor has marked the RF filter enable control as reserved in
the datasheet; remove it from the driver.

Fixes: e505edaedcb9 ("Input: add support for Azoteq IQS7222A/B/C")
Signed-off-by: Jeff LaBundy <jeff@labundy.com>
Link: https://lore.kernel.org/r/20220626072412.475211-7-jeff@labundy.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/misc/iqs7222.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/input/misc/iqs7222.c b/drivers/input/misc/iqs7222.c
index e65260d290cc..b2e8097a2e6d 100644
--- a/drivers/input/misc/iqs7222.c
+++ b/drivers/input/misc/iqs7222.c
@@ -557,13 +557,6 @@ static const struct iqs7222_prop_desc iqs7222_props[] = {
 		.reg_width = 4,
 		.label = "current reference trim",
 	},
-	{
-		.name = "azoteq,rf-filt-enable",
-		.reg_grp = IQS7222_REG_GRP_GLBL,
-		.reg_offset = 0,
-		.reg_shift = 15,
-		.reg_width = 1,
-	},
 	{
 		.name = "azoteq,max-counts",
 		.reg_grp = IQS7222_REG_GRP_GLBL,
-- 
2.37.2



