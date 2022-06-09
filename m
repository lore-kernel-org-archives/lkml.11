Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35699C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 12:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242012AbiFIMnC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 08:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbiFIMm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:42:58 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0539C3055A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:42:56 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2A06340002;
        Thu,  9 Jun 2022 12:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654778575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gauR0IeO9V9B4LdpFBz+k8Phc4tQZsAP0b5/H8FNiXY=;
        b=aBwF1q0l531gsHNFUF30uoJqYrAni6Zi3U59vOuenMU55l6sTd3VE7PbxHWEGRF8gCPouo
        0HiWvnvKvgYZTkWoze4V7YhL1OZJ/dL7KJG9VzjYi/uIhVDbd4u755AUNvAdMDXhS7bXd8
        Z2vPalpt/FvIY/jROQ8Q4I4z8t+EKJbN/D7lR936o6F1nNFKKrOBjtj1DEI+0TC/ujqksc
        oTaRDPfZ526DPqzJ6YcZEDiACQO8fF2lpvaBQGdM89SEvpgSkJ85UY45Yl2kSc7USBxaVS
        BFVPlV6oggUN5W6dIeatIvRTsTnUe+ExWun8WFzaoUDR5H1uS3/v4N7Zv/VyOQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Duoming Zhou <duoming@zju.edu.cn>, linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, richard@nod.at,
        vigneshr@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: Fix deadlock caused by cancel_work_sync in sm_release
Date:   Thu,  9 Jun 2022 14:42:53 +0200
Message-Id: <20220609124253.133037-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220524044841.10517-1-duoming@zju.edu.cn>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'5d262da93ba727c7dd09e0a247314a0befc2bb58'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-24 at 04:48:41 UTC, Duoming Zhou wrote:
> There is a deadlock between sm_release and sm_cache_flush_work
> which is a work item. The cancel_work_sync in sm_release will
> not return until sm_cache_flush_work is finished. If we hold
> mutex_lock and use cancel_work_sync to wait the work item to
> finish, the work item also requires mutex_lock. As a result,
> the sm_release will be blocked forever. The race condition is
> shown below:
> 
>     (Thread 1)             |   (Thread 2)
> sm_release                 |
>   mutex_lock(&ftl->mutex)  | sm_cache_flush_work
>                            |   mutex_lock(&ftl->mutex)
>   cancel_work_sync         |   ...
> 
> This patch moves del_timer_sync and cancel_work_sync out of
> mutex_lock in order to mitigate deadlock.
> 
> Fixes: 7d17c02a01a1 ("mtd: Add new SmartMedia/xD FTL")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
