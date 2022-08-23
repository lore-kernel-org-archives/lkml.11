Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932A6C32793
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 11:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357279AbiHWLKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 07:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356910AbiHWLJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 07:09:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FEA876A6;
        Tue, 23 Aug 2022 02:16:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8322E60F54;
        Tue, 23 Aug 2022 09:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872D1C433D7;
        Tue, 23 Aug 2022 09:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661246178;
        bh=U1YidWuVoyqZs3ej4kXKap1Dt9pgAIknPE6V3h/CqC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eCIU4aAGfIaTml393bAhNO5C2Y6pCsthyBfS/a1vgsPe9o2N4MkV1Gaz2qptKpSNv
         E620eTapHAydSvp+o08AHQoZOE8XrPsnnsQdZivkAa7ClLTrHL67t1vdvGlD0yBymI
         eOGFRZgrZJIud/KmkPN+I01mPjd7JJpfNCdn8yCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 5.4 026/389] fbcon: Fix boundary checks for fbcon=vc:n1-n2 parameters
Date:   Tue, 23 Aug 2022 10:21:44 +0200
Message-Id: <20220823080116.793037665@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080115.331990024@linuxfoundation.org>
References: <20220823080115.331990024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit cad564ca557f8d3bb3b1fa965d9a2b3f6490ec69 upstream.

The user may use the fbcon=vc:<n1>-<n2> option to tell fbcon to take
over the given range (n1...n2) of consoles. The value for n1 and n2
needs to be a positive number and up to (MAX_NR_CONSOLES - 1).
The given values were not fully checked against those boundaries yet.

To fix the issue, convert first_fb_vc and last_fb_vc to unsigned
integers and check them against the upper boundary, and make sure that
first_fb_vc is smaller than last_fb_vc.

Cc: stable@vger.kernel.org # v4.19+
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Helge Deller <deller@gmx.de>
Link: https://patchwork.freedesktop.org/patch/msgid/YpkYRMojilrtZIgM@p100
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/core/fbcon.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -123,8 +123,8 @@ static int logo_lines;
    enums.  */
 static int logo_shown = FBCON_LOGO_CANSHOW;
 /* console mappings */
-static int first_fb_vc;
-static int last_fb_vc = MAX_NR_CONSOLES - 1;
+static unsigned int first_fb_vc;
+static unsigned int last_fb_vc = MAX_NR_CONSOLES - 1;
 static int fbcon_is_default = 1; 
 static int primary_device = -1;
 static int fbcon_has_console_bind;
@@ -474,10 +474,12 @@ static int __init fb_console_setup(char
 			options += 3;
 			if (*options)
 				first_fb_vc = simple_strtoul(options, &options, 10) - 1;
-			if (first_fb_vc < 0)
+			if (first_fb_vc >= MAX_NR_CONSOLES)
 				first_fb_vc = 0;
 			if (*options++ == '-')
 				last_fb_vc = simple_strtoul(options, &options, 10) - 1;
+			if (last_fb_vc < first_fb_vc || last_fb_vc >= MAX_NR_CONSOLES)
+				last_fb_vc = MAX_NR_CONSOLES - 1;
 			fbcon_is_default = 0; 
 			continue;
 		}


