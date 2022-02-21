Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F2FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 16:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381364AbiBUQzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 11:55:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbiBUQzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:55:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E1B22534;
        Mon, 21 Feb 2022 08:55:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 041BB61382;
        Mon, 21 Feb 2022 16:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C569C340E9;
        Mon, 21 Feb 2022 16:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645462514;
        bh=jrQMS32Y1cpaAZL7S0U/5LN6RhNCJS/O/ftu+R/tX2E=;
        h=From:To:Cc:Subject:Date:From;
        b=PEiOT0VX8RzZ2Wc4wowdCPbk9UCNYymMqf20I+hPVEbalNw7N+sdZP/d0cUqx4QiT
         u84xA+fJqZQ2swnLqE8ohgbMrvtslHNNiA3SVsTQXZBM/FX5Tfm/YXLWkfCPgBN9om
         SYcuO01IkbBJHx918Ki8HgDfIuekEJqMdQyKCJ/J2uHvVA0FZXsAdb789WQWjSUGEV
         Cui5sSzTn36CVFTByrtQoaJ6bHmq54ai5gT9GJXgpjgaD0yVGHkyI9NsbdBtLxXp3O
         b6nt5Xa4g2mveiaYDIV+DD8k7BppTKzN9rXl2ZX2AxXnx4At09oiirwqnBLcHHODJl
         uX2O1x6ro3eIQ==
From:   broonie@kernel.org
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     build@vger.kernel.org, failure@vger.kernel.org,
        after@vger.kernel.org, merge@vger.kernel.org, of@vger.kernel.org,
        the@vger.kernel.org, BRANCH@vger.kernel.org, tree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: drivers/memstick/core/ms_block.c
Date:   Mon, 21 Feb 2022 16:55:08 +0000
Message-Id: <20220221165508.2633962-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the mmc tree, today's linux-next build (x86 allmodconfig)
failed like this:

/tmp/next/build/drivers/memstick/core/ms_block.c:158:6: error: implicit declaration of function 'bitmap_weight_eq'; did you mean 'bitmap_weight'? [-Werror=implicit-function-declaration]
  158 |  if (bitmap_weight_eq(msb->used_blocks_bitmap, msb->block_count,
      |      ^~~~~~~~~~~~~~~~
      |      bitmap_weight

Caused by commit

  5f8d171cd8a93f ("memstick: replace bitmap_weight with bitmap_weight_eq where appropriate")

I used the mmc tree from 20220217 instead.
