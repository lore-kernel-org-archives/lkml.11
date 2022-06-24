Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221F3C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 18:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbiFXStF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 14:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiFXStD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:49:03 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DED17E03A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:49:01 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4F0A9100003;
        Fri, 24 Jun 2022 18:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656096540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ih1cpLz/KI7jvENNa5R73c8BakQ/fBBWVL3gh1DAWw=;
        b=oUfSu6LWRcfjNA9z+NJke9PkcvVpE64zMMPcnnVCpYUO2IRe8RmTFGQAswe1YxkcjOKKUh
        ROIIscx1j2kS6gMTMWg0SKycM2vXzIA1RfHYgdcahIPRGIQDyfrIgS1TI9KhEW2t0FJfT9
        T5kFk0TL2H2a2ByPm2DVE1kjvIJyvOhjhEv0hHZ/j/+kROQxqOeVI9lsjap2v+Pa2NdEVo
        rv/wgt8O/4H2anWjvF1fBuGr9DV7NKBKM4flGhHRzi448YKzHsDjv/GQKlR2oQKZOVE2bf
        yFUPCi9XaYUv2qirLcr1bwp4ZjcwJrW2dTYoipJI8NuLf1ZJnf3XTvMCALrCzg==
From:   miquel.raynal@bootlin.com
To:     Jiang Jian <jiangjian@cdjrlc.com>, miquel.raynal@bootlin.com,
        vigneshr@ti.com
Cc:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: sm_common: drop unexpected word 'is' in the comments
Date:   Fri, 24 Jun 2022 20:48:58 +0200
Message-Id: <20220624184858.1888057-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220622160511.11679-1-jiangjian@cdjrlc.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'431eae20a093fe3a47cf617b01b911ef39ce3a83'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

On Wed, 2022-06-22 at 16:05:11 UTC, Jiang Jian wrote:
> there is an unexpected word 'is' in the comments that need to be dropped
> 
> file: drivers/mtd/nand/raw/sm_common.c
> line: 55
> 
> /* NOTE: This layout is is not compatabable with SmartMedia, */
> 
> changed to:
> 
> /* NOTE: This layout is not compatabable with SmartMedia, */
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
