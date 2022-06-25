Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EB4C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jun 2022 12:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiFYMzV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jun 2022 08:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbiFYMzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 08:55:20 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF0612D09
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 05:55:18 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 55Jkobhq9L5fD55JkoLyce; Sat, 25 Jun 2022 14:55:16 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 25 Jun 2022 14:55:16 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] memstick/ms_block:
Date:   Sat, 25 Jun 2022 14:55:14 +0200
Message-Id: <cover.1656155715.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie is related to bitmap usage in memstick/ms_block.

Patch 1 use the dedicated bitmap API to make sure that a number of long is
allocated, instead of a number of bytes. 

Patch 2 fix a memory leak. This is speculative.

Pacth 3 is just a clean up to make more use of the bitmap API mostly for
consistancy reason.

Christophe JAILLET (3):
  memstick/ms_block: Fix some incorrect memory allocation
  memstick/ms_block: Fix a memory leak
  memstick/ms_block: Use the bitmap API when applicable

 drivers/memstick/core/ms_block.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.34.1

