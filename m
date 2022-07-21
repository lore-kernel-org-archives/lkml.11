Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA06DC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jul 2022 20:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiGUUtZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 16:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiGUUtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:49:22 -0400
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10688FD50
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 13:49:20 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id Ed6jo8JEQQUcTEd6kof0aX; Thu, 21 Jul 2022 22:49:18 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 21 Jul 2022 22:49:18 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 0/3] ocfs2: A few clean_ups
Date:   Thu, 21 Jul 2022 22:49:16 +0200
Message-Id: <cover.1658436259.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 and 2 were patch 1/3 and 3/3 in v1.
Code is unchanged and R-b tag are already added.

Patch 3 is new. It is just a typo

Christophe JAILLET (3):
  ocfs2: Remove some useless functions
  ocfs2: use the bitmap API to simplify code
  ocfs2: Fix a typo in a comment

 fs/ocfs2/heartbeat.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

-- 
2.34.1

