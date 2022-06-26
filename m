Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22E3C43334
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jun 2022 05:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiFZFwl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jun 2022 01:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiFZFwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 01:52:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122F312778
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 22:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=zwx5Svpj0Ro/UPJKmY0oNTC1x1wYqztY5B1xeCB49S4=; b=F3sWX83IIuJpvV9ZkcA03mtXNl
        oAYusD5wkL0bBiKKKoGb97E3gewpXr5zD2wQ/89ljziXzithgG++He30A2OG5RjbcGfKJ48b2UB9w
        +fEIBZugUDAZp/h37kG6zPd87Or1zAbCtus5CiuqxosDJZhnEXZCc6/RBTeQQjRmA38YoAU66PTTJ
        vB8UTie4nAZ6VeN492Z2rN80FuLgHgkAxiXgpOzP8VMs9Zt4Ogrq0mc0IzbwHopLH0la+6ppg8c+7
        Ljkmmf2U9f6xYoE9JjiAMPaLOSTo2MZxfb768N6/58eNE9YDapH97eC9Nv6m1AYXPPuTidAEmBGo3
        v+M2sWig==;
Received: from [2001:4bb8:199:3788:15b9:a02f:7fe3:abaf] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o5LCG-009vHw-T9; Sun, 26 Jun 2022 05:52:37 +0000
Date:   Sun, 26 Jun 2022 07:52:34 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fix for Linux 5.19
Message-ID: <Yrf0ItiAJ4cVfdPf@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.19-2022-06-26

for you to fetch changes up to 3be4562584bba603f33863a00c1c32eecf772ee6:

  dma-direct: use the correct size for dma_set_encrypted() (2022-06-23 15:26:59 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 5.19

 - pass the correct size to dma_set_encrypted() when freeing memory
   (Dexuan Cui)

----------------------------------------------------------------
Dexuan Cui (1):
      dma-direct: use the correct size for dma_set_encrypted()

 kernel/dma/direct.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
